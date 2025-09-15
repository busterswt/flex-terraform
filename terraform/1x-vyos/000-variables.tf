resource "random_pet" "pet_name" {
  length = 2
}

variable "vm_image" {
  type    = map(string)
  description = "The UUID and name of the server image"
  default = {}
}

variable "vm_flavor" {
  type    = string
  description = "The UUID of the flavor to use for the server."
  default = ""
}

variable "fw_image" {
  type    = map(string)
  description = "The UUID and name of the firewall image."
  default = {}
}

variable "fw_flavor" {
  type    = string
  description = "The UUID of the flavor to use for the firewall."
  default = ""
}

variable "external_network" {
  type    = map(string)
  description = "The NAME and UUID of an External Provider Network for Floating IPs (dict)."
  default = {}
}

variable "dns_nameservers" {
  type    = list(string)
  default = ["1.1.1.1", "1.0.0.1"]
}

####################
# Networks/Subnets #
####################

variable "transit_network" {
  type = map(string)
  default = {
    subnet_name = "transit-network-169.254.169.224/29"
    cidr        = "169.254.169.224/29"
  }
}

variable "tenant_network" {
  type = map(string)
  default = {
    subnet_name = "tenant-network-192.168.40.0/24"
    cidr        = "192.168.40.0/24"
  }
}

###########
# Routers #
###########

variable "tenant_router" {
  type = map(string)
  default = {
    name        = "tenant-router"
  }
}

##########
# Routes #
##########

variable "vpn_routes" {
  type = set(object({
    destination = string
  }))
  description = "'Interesting' traffic for VPN"
  default = []
}
