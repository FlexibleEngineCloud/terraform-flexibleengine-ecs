module "ecs_user_data" {
  source = "../../"

  instance_name     = "ecs-test-userdata"
  instance_count    = 1
  availability_zone = "eu-west-0a"

  image_id        = "OBS_U_Ubuntu_16.04"
  flavor_name     = "t2.small"
  key_name        = var.key_pair
  security_groups = var.security_group_id
  subnet_id       = var.subnet_id
  network_id      = var.network_id

  user_data = data.template_cloudinit_config.config.rendered

  attach_eip = false

  metadata = {
    Terraform   = "true"
    Environment = "dev"
  }
}
