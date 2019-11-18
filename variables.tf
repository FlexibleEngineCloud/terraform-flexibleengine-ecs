variable "instance_name" {
  description = "Name of the ECS instance and the associated volume"
  type        = string
}

variable "instance_count" {
  description = "Number of instances to launch"
  default     = 1
  type        = number
}

variable "attach_eip" {
  description = "Whether or not attache elastic IP (public IP)"
  default     = false
  type        = bool
}

variable "ext_net_name" {
  description = "External network name (do not change)"
  default     = "admin_external_net"
  type        = string
}

variable "image_id" {
  description = "ID of Image to use for the instance"
  type        = string
}

variable "flavor_name" {
  description = "The flavor type of instance to start"
  type        = string
}

variable "network_id" {
  description = "The network ID to launch in"
  type        = string
}

variable "subnet_id" {
  description = "The subnet ID to launch in"
  type        = string
}

variable "security_groups" {
  description = "A list of security group IDs to associate with"
  type        = list(string)
}

variable "sysvol_type" {
  description = "The type of the system volume: SATA for standard I/O or SSD for high I/O"
  default     = "SATA"
  type        = string
}

variable "sysvol_size" {
  description = "The size of the system volume in GB"
  default     = "40"
  type        = number
}

variable "key_name" {
  description = "The key pair name"
  type        = string
}

variable "availability_zone" {
  description = "The availability zone to launch where"
  type        = string
}

variable "metadata" {
  description = "A mapping of metadata to assign to the resource"
  default     = {}
  type        = map(string)
}

variable "user_data" {
  description = "The user data to provide when launching the instance"
  default     = ""
  type        = string
}

variable "dns_record" {
  description = "Whether or not create a DNS record for these instances"
  default     = false
  type        = bool
}

variable "domain_id" {
  description = "ID of the domain if dns_record is set to true"
  default     = ""
  type        = string
}

variable "domain_name" {
  description = "Name of the domain if dns_record is set to true"
  default     = ""
  type        = string
}

variable "record_ttl" {
  description = "TTL of the A record if dns_record is set to true"
  default     = "300"
  type        = number
}


variable "endpoint" {
  description = "Endpoint URL of the Flexible Engine provider"
  type        = string
  default     = "https://iam.eu-west-0.prod-cloud-ocb.orange-business.com/v3"
}

variable "region" {
  description = "Region of the Flexible Engine provider"
  type        = string
  default     = "eu-west-0"
}
