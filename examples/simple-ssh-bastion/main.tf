data "flexibleengine_images_image_v2" "image" {
  name        = var.image_name
  most_recent = true
}

module "ecs_simple_ssh_bastion" {
  source = "../..//"

  instance_name     = "simple-ssh-bastion"
  instance_count    = 1
  availability_zone = "eu-west-0a"

  flavor_name     = var.flavor_name
  key_name        = var.key_pair
  security_groups = var.security_group_id
  subnet_id       = var.subnet_id
  network_id      = var.network_id

  new_eip       = var.new_eip
  eip_bandwidth = var.eip_bandwidth

  user_data = var.ssh_port != null ? data.template_cloudinit_config.sshd_config[0].rendered : ""

  block_devices = [
    {
      uuid                  = data.flexibleengine_images_image_v2.image.id
      source_type           = "image"
      destination_type      = "volume"
      volume_size           = 50
      boot_index            = 0
      delete_on_termination = true
      volume_type           = "SATA"
    }
  ]

  metadata = {
    Terraform   = "true"
    Environment = "dev"
  }
}
