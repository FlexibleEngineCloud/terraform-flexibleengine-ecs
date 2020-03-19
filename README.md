# Flexible Engine ECS Terraform Module

Terraform module which creates ECS resource on Flexible Engine

> A DNS record can be created for the created ECS instances. This feature is available only for private zone for now.

## Terraform version 0.12

## Usage : Terraform

```hcl
module "ecs_cluster" {
  source = "modules/terraform-fe-ecs"

  instance_name  = "my-cluster"
  instance_count = 2
  availability_zone = "eu-west-0a"

  flavor_name        = "t2.small"
  key_name           = "my-key"
  security_groups    = ["sg-group-id-1","sg-group-id-2"]
  subnet_id          = "my-subnet-id"
  network_id         = "my-network-id"

  new_eip = false

  dns_record  = true
  domain_id   = "my-domain-id"
  domain_name = "my-domain-name"

  block_devices = [
    {
      uuid = "<ImageID>"
      source_type = "image"
      destination_type = "volume"
      volume_size = 50
      boot_index = 0
      delete_on_termination = true
      volume_type = "SATA" #SATA/SSD
    }
  ]

  metadata = {
    Terraform = "true"
    Environment = "dev"
  }
}
```

## Usage : Terragrunt

```hcl
################################
### Terragrunt Configuration ###
################################

terraform {
  source = "git::https://github.com/terraform-flexibleengine-modules/terraform-flexibleengine-ecs.git"

}

include {
  path = find_in_parent_folders()
}

##################
### Parameters ###
##################

inputs = {
    instance_name     = "test"
    instance_count    = 1

    flavor_name     = "s3.large.2"
    key_name        = "<keypair>"
    security_groups = []
    subnet_id       = "<subnet-id>"
    network_id      = "<network-id>"

    new_eip = true

    dns_record  = false
    domain_id   = ""
    domain_name = ""

    block_devices = [
      {
        uuid = "<ImageID>"
        source_type = "image"
        destination_type = "volume"
        volume_size = 50
        boot_index = 0
        delete_on_termination = true
        volume_type = "SATA" #SATA/SSD
      }
    ]

    metadata = {
                  Terraform = "true"
                  Environment = "dev"
               }


}

```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| attach\_eip | Whether or not attache elastic IP (public IP) | bool | `"false"` | no |
| availability\_zone | The availability zone to launch where | string | n/a | yes |
| dns\_record | Whether or not create a DNS record for these instances | bool | `"false"` | no |
| domain\_id | ID of the domain if dns_record is set to true | string | `""` | no |
| domain\_name | Name of the domain if dns_record is set to true | string | `""` | no |
| ext\_net\_name | External network name (do not change) | string | `"admin_external_net"` | no |
| flavor\_name | The flavor type of instance to start | string | n/a | yes |
| instance\_count | Number of instances to launch | number | `"1"` | no |
| instance\_name | Name of the ECS instance and the associated volume | string | n/a | yes |
| key\_name | The key pair name | string | n/a | yes |
| metadata | A mapping of metadata to assign to the resource | map(string) | `{}` | no |
| network\_name | The network name to attach (Required if network_id is null) | string | n/a | yes |
| network\_id | The network ID to launch in (Required if network_name is null) | string | n/a | yes |
| record\_ttl | TTL of the A record if dns_record is set to true | number | `"300"` | no |
| security\_groups | A list of security group IDs to associate with | list(string) | n/a | yes |
| subnet\_id | The subnet ID to launch in (Required if network_name is null) | string | n/a | yes |
| user\_data | The user data to provide when launching the instance | string | `""` | no |
| block\_devices | List of block devices to attach/create to the ECS instance(s) | list(object({ uuid = string source_type = string destination_type = string volume_size = number boot_index = number delete_on_termination = bool volume_type = string })) | n/a | yes |
| allowed\_address\_pairs | Source/destination check configuration (1.1.1.1/0 for global disable source/destination checks, or list of subnet) | list(object({ ip_address = string mac_address = string })) | `[]` | no |
| ip\_address | Fixed IP Address| string | null | no |

## Outputs

| Name | Description |
|------|-------------|
| id | list of IDs of the created servers |
| name | list of names of the created servers |
| private\_ip | List of ipv4 addresses of the created servers |
| public\_ip | List of public floating ip addresses of the created servers |
