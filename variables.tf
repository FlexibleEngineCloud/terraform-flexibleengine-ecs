variable "instance_name" {
  description = "Name of the ECS instance and the associated volume"
  type        = string
}

variable "instance_count" {
  description = "Number of instances to launch"
  default     = 1
  type        = number
}

variable "new_eip" {
  description = "Whether or not attach new Elastic IP (public IP) to ECS"
  default     = false
  type        = bool
}

variable "eip_bandwidth" {
  description = "Bandwidth of the EIP in Mbit/s"
  default     = null
  type        = number
}

variable "existing_eip" {
  description = "Existing IPs (public IPs) to be attached to ECS"
  default     = []
  type        = list
}

variable "ext_net_name" {
  description = "External network name (do not change)"
  default     = "admin_external_net"
  type        = string
}

variable "flavor_name" {
  description = "The flavor type of instance to start"
  type        = string
}

variable "network_id" {
  description = "The network ID to launch in"
  type        = string
  default     = ""
}

variable "network_name" {
  description = "The network ID to launch in"
  type        = string
  default     = null
}

variable "subnet_id" {
  description = "The subnet ID to launch in"
  type        = string
  default     = ""
}

variable "security_groups" {
  description = "A list of security group IDs to associate with"
  type        = list(string)
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

variable "tags" {
  description = "A mapping of tags to assign to the resource"
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


variable "block_devices" {
  description = "List of block devices to attach/create to the ECS instance(s)"
  type = list(object({
    uuid                  = string
    source_type           = string
    destination_type      = string
    volume_size           = number
    volume_type           = string
    boot_index            = number
    delete_on_termination = bool
  }))
}

variable "allowed_address_pairs" {
  description = "Source/destination check configuration (1.1.1.1/0 for global disable source/destination checks, or list of subnet)"
  default     = []
  type = list(object({
    ip_address  = string
    mac_address = string
  }))
}

variable "ip_address" {
  description = "Fixed IP Address"
  default     = null
  type        = string
}

variable "scheduler_hints" {
  description = "Provide the Nova scheduler with hints on how the instance should be launched"
  default     = []
  type = list(object({
    group              = string
    different_host     = list(string)
    same_host          = list(string)
    query              = list(string)
    target_cell        = string
    build_near_host_ip = string
  }))
}