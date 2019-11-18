locals {
  this_id = compact(
    concat(flexibleengine_compute_instance_v2.instance.*.id, [""]),
  )
}

output "private_ip" {
  description = "List of ipv4 addresses of the created servers"
  value       = [flexibleengine_compute_instance_v2.instance.*.access_ip_v4]
}

output "public_ip" {
  description = "List of public floating ip addresses of the created servers"
  value       = [flexibleengine_networking_floatingip_v2.fip.*.address]
}

output "id" {
  description = "list of IDs of the created servers"
  value       = [local.this_id]
}

output "name" {
  description = "list of names of the created servers"
  value       = [flexibleengine_compute_instance_v2.instance.*.name]
}

