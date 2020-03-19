# ECS Instance with existing EIP attachement

Create three basic ECS instances and attach existing EIPs (creted by terraform-flexibleengine-eip for instance).

Requirements: a SSH key pair, network, subnet and security group already created

## Usage

Fil in the required parameters into `parameters.tfvars` (or create a new your-parameters-file.auto.tfvars that will be automatically used by Terraform -> no need to use -var-file= on the following commands)

Then run the Terraform commands:

```bash
$ terraform init
$ terraform plan -var-file=parameters.tfvars
$ terraform apply -var-file=parameters.tfvars
```
