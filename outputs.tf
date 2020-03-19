output "private_ip" {
  description = "List of ipv4 addresses of the created servers"
  value       = flexibleengine_compute_instance_v2.instances.*.access_ip_v4
}

output "public_ip" {
  description = "List of public floating ip addresses of the created servers"
  value       = var.new_eip == true ? [for publicip in flexibleengine_vpc_eip_v1.new_eip.*.publicip: lookup(element(publicip, 0), "ip_address")] : var.existing_eip
}

output "neutron_ports_id" {
  description = "List of neutron ports of the created servers"
  value       = flexibleengine_networking_port_v2.instance_port.*.id
}

output "id" {
  description = "list of IDs of the created servers"
  value = flexibleengine_compute_instance_v2.instances.*.id
}

output "name" {
  description = "list of names of the created servers"
  value       = flexibleengine_compute_instance_v2.instances.*.name
}

