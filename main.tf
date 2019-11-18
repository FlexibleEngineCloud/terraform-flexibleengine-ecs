# ECS Instance Module

terraform {
  required_version = ">= 0.12.0"
}

resource "flexibleengine_blockstorage_volume_v2" "instance_sysvol" {
  availability_zone = var.availability_zone
  count             = var.instance_count
  name              = "${var.instance_count > 1 ? format("%s-%d", var.instance_name, count.index + 1) : var.instance_name}-sysvol"
  size              = var.sysvol_size
  image_id          = var.image_id
  volume_type       = var.sysvol_type
}

resource "flexibleengine_compute_instance_v2" "instance" {
  availability_zone = var.availability_zone
  count             = var.instance_count
  name              = var.instance_count > 1 ? format("%s-%d", var.instance_name, count.index + 1) : var.instance_name
  flavor_name       = var.flavor_name
  key_pair          = var.key_name
  user_data         = var.user_data

  block_device {
    uuid                  = flexibleengine_blockstorage_volume_v2.instance_sysvol[count.index].id
    source_type           = "volume"
    destination_type      = "volume"
    volume_size           = flexibleengine_blockstorage_volume_v2.instance_sysvol[count.index].size
    boot_index            = 0
    delete_on_termination = true
  }

  network {
    port           = flexibleengine_networking_port_v2.instance_port[count.index].id
    access_network = true
  }

  metadata = merge(
    var.metadata,
    {
      "Name" = var.instance_count > 1 ? format("%s-%d", var.instance_name, count.index + 1) : var.instance_name
    },
  )
}

resource "flexibleengine_networking_port_v2" "instance_port" {
  network_id         = var.network_id
  count              = var.instance_count
  security_group_ids = var.security_groups
  admin_state_up     = "true"

  fixed_ip {
    subnet_id = var.subnet_id
  }
}

resource "flexibleengine_networking_floatingip_v2" "fip" {
  count = var.attach_eip ? var.instance_count : 0
  pool  = var.ext_net_name
  port_id = element(
    flexibleengine_networking_port_v2.instance_port.*.id,
    count.index,
  )
  depends_on = [flexibleengine_compute_instance_v2.instance]
}

resource "flexibleengine_dns_recordset_v2" "recordset" {
  count       = var.dns_record ? var.instance_count : 0
  zone_id     = var.domain_id
  name        = "${var.instance_count > 1 ? format("%s-%d", var.instance_name, count.index + 1) : var.instance_name}.${var.domain_name}."
  description = "DNS record for instance ${var.instance_count > 1 ? format("%s-%d", var.instance_name, count.index + 1) : var.instance_name}"
  ttl         = var.record_ttl
  type        = "A"
  records     = [flexibleengine_compute_instance_v2.instance[count.index].access_ip_v4]
}

