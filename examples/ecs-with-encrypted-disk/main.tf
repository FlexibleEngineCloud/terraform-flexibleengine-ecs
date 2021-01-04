resource "flexibleengine_blockstorage_volume_v2" "data_volume" {
  name        = "data_volume"
  description = "My Data Volume"
  size        = 50
  metadata = {
    __system__encrypted = "1"
    __system__cmkid     = var.kms_id
  }
}

module "basic_ecs" {
  source = "../../"

  instance_name     = "ecs-encrypt"
  instance_count    = 1
  availability_zone = "eu-west-0a"

  flavor_name     = "t2.small"
  key_name        = var.key_pair
  security_groups = var.security_group_id
  subnet_id       = var.subnet_id
  network_id      = var.network_id

  block_devices = [
    {
      uuid                  = var.image_id
      source_type           = "image"
      destination_type      = "volume"
      volume_size           = 50
      boot_index            = 0
      delete_on_termination = true
      volume_type           = "SATA"
    },
    {
      uuid                  = flexibleengine_blockstorage_volume_v2.data_volume.id
      source_type           = "volume"
      destination_type      = "volume"
      volume_size           = 50
      boot_index            = 1
      delete_on_termination = false
      volume_type           = "SATA"
    }
  ]

  metadata = {
    Terraform   = "true"
    Environment = "dev"
  }
}
