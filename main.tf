# ECS Instance Module

terraform {
  required_version = ">= 0.12.0"
}

data "flexibleengine_vpc_subnet_v1" "networks" {
  count = var.network_name != null ? 1 : 0
  name  = var.network_name
}

resource "flexibleengine_compute_instance_v2" "instances" {
  availability_zone = var.availability_zone
  count             = var.instance_count
  name              = var.instance_count > 1 ? format("%s-%d", var.instance_name, count.index + 1) : var.instance_name
  flavor_name       = var.flavor_name
  key_pair          = var.key_name
  user_data         = var.user_data

  network {
    port           = flexibleengine_networking_port_v2.instance_port[count.index].id
    access_network = true
  }


  dynamic "block_device" {
    for_each = var.block_devices
    content {
      uuid                  = block_device.value.uuid != "" ? block_device.value.uuid : null
      source_type           = block_device.value.source_type      # image/volume/snapshot/blank(ephemeral)
      destination_type      = block_device.value.destination_type # volume/local(epheremal)/blank
      volume_size           = block_device.value.volume_size
      boot_index            = block_device.value.boot_index #-1 : local/0: Boot disk/1: Data disk
      delete_on_termination = block_device.value.delete_on_termination ? block_device.value.delete_on_termination : null
    }
  }


  metadata = merge(
    var.metadata,
    {
      "Name" = var.instance_count > 1 ? format("%s-%d", var.instance_name, count.index + 1) : var.instance_name
    },
  )
}

resource "flexibleengine_networking_port_v2" "instance_port" {
  network_id         = var.network_name != null ? data.flexibleengine_vpc_subnet_v1.networks[0].id : var.network_id
  count              = var.instance_count
  security_group_ids = var.security_groups
  admin_state_up     = "true"

  fixed_ip {
    subnet_id  = var.network_name != null ? data.flexibleengine_vpc_subnet_v1.networks[0].subnet_id : var.subnet_id
    ip_address = var.ip_address
  }

  dynamic "allowed_address_pairs" {
    for_each = var.allowed_address_pairs
    content {
      ip_address  = allowed_address_pairs.value.ip_address
      mac_address = allowed_address_pairs.value.mac_address
    }
  }

}

resource "flexibleengine_networking_floatingip_v2" "fip" {
  count = var.attach_eip ? var.instance_count : 0
  pool  = var.ext_net_name
  port_id = element(
    flexibleengine_networking_port_v2.instance_port.*.id,
    count.index,
  )
  depends_on = [flexibleengine_compute_instance_v2.instances]
}

resource "flexibleengine_dns_recordset_v2" "recordset" {
  count       = var.dns_record ? var.instance_count : 0
  zone_id     = var.domain_id
  name        = "${var.instance_count > 1 ? format("%s-%d", var.instance_name, count.index + 1) : var.instance_name}.${var.domain_name}."
  description = "DNS record for instance ${var.instance_count > 1 ? format("%s-%d", var.instance_name, count.index + 1) : var.instance_name}"
  ttl         = var.record_ttl
  type        = "A"
  records     = [flexibleengine_compute_instance_v2.instances[count.index].access_ip_v4]
}
