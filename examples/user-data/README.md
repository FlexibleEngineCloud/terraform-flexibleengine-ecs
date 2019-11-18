# ECS Instance with user data

Create an ECS instance with user data that trigger two shell script.

Once ECS instance created, you'll be able to list two files in /var/tmp : action_a and action_b that contains the two variables set into parameters.tfvars (action_a and action_b)

Requirements: a SSH key pair, network, subnet and security group already created

## Usage

Fil in the requiered parameters into `parameters.tfvars` file.

Then run the Terraform commands: 

```bash
$ terraform init
$ terraform plan -var-file=parameters.tfvars
$ terraform apply -var-file=parameters.tfvars
```