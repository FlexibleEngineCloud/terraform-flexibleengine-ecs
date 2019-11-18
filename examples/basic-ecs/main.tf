module "basic_ecs" {
  source = "../../"

  instance_name     = "ecs-basic"
  instance_count    = 1
  availability_zone = "eu-west-0a"

  image_id        = "0249222b-c9be-419b-a953-f47e91c3fc81"
  flavor_name     = "t2.small"
  key_name        = var.key_pair
  security_groups = var.security_group_id
  subnet_id       = var.subnet_id
  network_id      = var.network_id

  attach_eip = false

  metadata = {
    Terraform   = "true"
    Environment = "dev"
  }
}
