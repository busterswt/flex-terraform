# Params file for variables

#### GLANCE
variable "image" {
  type    = string
  default = "jammy-raw"
}

#### NEUTRON
variable "external_network" {
  type    = string
  default = "PUBLICNET"
}

# UUID of external gateway
variable "external_gateway" {
  type    = string
  default = "1692d064-d011-4589-a39d-0e64b15e88da"
}

variable "dns_ip" {
  type    = list(string)
  default = ["8.8.8.8", "8.8.4.4"]
}

#### VM HTTP parameters ####
variable "flavor_http" {
  type    = string
  default = "r2.gp.gen0"
}

variable "network_http" {
  type = map(string)
  default = {
    subnet_name = "subnet-http"
    cidr        = "192.168.1.0/24"
  }
}

variable "http_instance_names" {
  type = set(string)
  default = ["http-instance-1"]
}
