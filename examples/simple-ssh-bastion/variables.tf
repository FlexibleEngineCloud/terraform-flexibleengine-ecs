variable "key_pair" {}
variable "image_name" {}

variable "network_id" {}
variable "subnet_id" {}
variable "security_group_id" {}

variable "ssh_port" {
  description = "The listening port of sshd"
  type        = number
  default     = null
}

variable "new_eip" {
  description = "Whether or not attach new Elastic IP (public IP) to ECS"
  default     = true
  type        = bool
}

variable "eip_bandwidth" {
  description = "Bandwidth of the EIP in Mbit/s"
  default     = 5
  type        = number
}
