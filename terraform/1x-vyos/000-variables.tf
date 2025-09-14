resource "random_pet" "pet_name" {
  length = 2
}

variable "vm_image" {
  type    = map(string)
  description = "The UUID and name of the server image"
  default = {"uuid":"d8cdd44b-744d-4afa-83ef-ffdbfb259e12", "name":"Ubuntu 24.04 LTS"}
}

variable "vm_flavor" {
  type    = string
  description = "The UUID of the flavor to use for the server. Default: gp5.2.4"
  default = "b5ccd490-b138-4d81-b8c3-c074287708e8"
}

variable "fw_image" {
  type    = map(string)
  description = "The UUID and name of the firewall image."
  default = {"uuid":"8effec91-f5e3-4860-a1ed-4c7fe2fbcc46", "name":"VyOS 1.4.3"}
}

variable "fw_flavor" {
  type    = string
  description = "The UUID of the flavor to use for the firewall. Default: gp.5.2.2"
  default = "d3a4a3f8-1aa3-4f9e-b08d-9081bb8aea08"
}

variable "external_network" {
  type    = map(string)
  description = "The NAME and UUID of an External Provider Network for Floating IPs (dict)."
  default = {"uuid":"82be3711-cd97-4f7c-8bbd-59f5524a949e", "name":"PUBLICNET"}
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

variable "vpn_route" {
  type    = map(string)
  description = "The encryption domain"
  default = {"destination":"10.240.0.0/24"}
}
