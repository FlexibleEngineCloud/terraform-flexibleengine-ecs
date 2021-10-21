module "ecs_user_data" {
  source = "../../"

  instance_name     = "ecs-test-userdata"
  instance_count    = 1
  availability_zone = "eu-west-0a"

  flavor_name     = "t2.small"
  key_name        = var.key_pair
  security_groups = [var.security_group_id]
  subnet_id       = var.subnet_id
  network_id      = var.network_id

  user_data = "${data.cloudinit_config.config.rendered}"

  block_devices = [
    {
      uuid                  = var.image_id
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
