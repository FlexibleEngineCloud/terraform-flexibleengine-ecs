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

  image_id           = "0249222b-c9be-419b-a953-f47e91c3fc81"
  flavor_name        = "t2.small"
  key_name           = "my-key"
  security_groups    = ["sg-group-id-1","sg-group-id-2"]
  subnet_id          = "my-subnet-id"
  network_id         = "my-network-id"

  attach_eip = false

  dns_record  = true
  domain_id   = "my-domain-id"
  domain_name = "my-domain-name"

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

    image_id        = "<image-id>"
    flavor_name     = "s3.large.2"
    key_name        = "<keypair>"
    security_groups = []
    subnet_id       = "<subnet-id>"
    network_id      = "<network-id>"

    attach_eip = true

    dns_record  = false
    domain_id   = ""
    domain_name = ""

    metadata = {
                  Terraform = "true"
                  Environment = "dev"
               }


}

```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
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
| image\_id | ID of Image to use for the instance | string | n/a | yes |
| instance\_count | Number of instances to launch | number | `"1"` | no |
| instance\_name | Name of the ECS instance and the associated volume | string | n/a | yes |
| key\_name | The key pair name | string | n/a | yes |
| metadata | A mapping of metadata to assign to the resource | map(string) | `{}` | no |
| network\_id | The network ID to launch in | string | n/a | yes |
| record\_ttl | TTL of the A record if dns_record is set to true | number | `"300"` | no |
| security\_groups | A list of security group IDs to associate with | list(string) | n/a | yes |
| subnet\_id | The subnet ID to launch in | string | n/a | yes |
| sysvol\_size | The size of the system volume in GB | number | `"40"` | no |
| sysvol\_type | The type of the system volume: SATA for standard I/O or SSD for high I/O | string | `"SATA"` | no |
| user\_data | The user data to provide when launching the instance | string | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | list of IDs of the created servers |
| name | list of names of the created servers |
| private\_ip | List of ipv4 addresses of the created servers |
| public\_ip | List of public floating ip addresses of the created servers |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
