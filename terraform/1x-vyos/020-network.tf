#### NETWORK CONFIGURATION ####

#################
#### ROUTERS ####
#################

# These routers will act as the edge device for any VMs deployed in
# customer Virtual Routing Domain (VRD).

resource "openstack_networking_router_v2" "tenant_router" {
  provider            = openstack.dfw3
  name                = "${join("-",["${random_pet.pet_name.id}","${var.tenant_router.name}"])}"
  admin_state_up      = true
  external_network_id = var.external_network["uuid"]
#  tenant_id           = openstack_identity_project_v3.fidget_spinners_inc.id
  enable_snat         = true
}


###########################
#### TRANSIT NETWORKS  ####
###########################

# The networks here connect the VPN concentrator to the
# tenant's vRouter

resource "openstack_networking_network_v2" "transit_network" {
  provider = openstack.dfw3
  name = "${join("-",["${random_pet.pet_name.id}","transit-network"])}"
#  tenant_id           = openstack_identity_project_v3.fidget_spinners_inc.id
}

resource "openstack_networking_subnet_v2" "transit_network" {
  provider        = openstack.dfw3
  name            = "${join("-",["${random_pet.pet_name.id}","${var.transit_network["subnet_name"]}"])}"
  network_id      = openstack_networking_network_v2.transit_network.id
  cidr            = var.transit_network["cidr"]
  dns_nameservers = var.dns_nameservers
#  tenant_id           = openstack_identity_project_v3.fidget_spinners_inc.id
}

resource "openstack_networking_router_interface_v2" "tenant-router-interface" {
  provider = openstack.dfw3
  router_id = "${openstack_networking_router_v2.tenant_router.id}"
  subnet_id = "${openstack_networking_subnet_v2.transit_network.id}"
}

##########################
#### TENANT NETWORKS  ####
##########################

# Sample tenant network that services one or more VMs
# that leverage the VPN concentrator for protected traffic

resource "openstack_networking_network_v2" "tenant_network" {
  provider = openstack.dfw3
  name = "${join("-",["${random_pet.pet_name.id}","tenant-network"])}"
}

resource "openstack_networking_subnet_v2" "tenant_network" {
  provider        = openstack.dfw3
  name            = "${join("-",["${random_pet.pet_name.id}","${var.tenant_network["subnet_name"]}"])}"
  network_id      = openstack_networking_network_v2.tenant_network.id
  cidr            = var.tenant_network["cidr"]
  dns_nameservers = var.dns_nameservers
}

resource "openstack_networking_router_interface_v2" "tenant-router-interface-2" {
  provider = openstack.dfw3
  router_id = "${openstack_networking_router_v2.tenant_router.id}"
  subnet_id = "${openstack_networking_subnet_v2.tenant_network.id}"
}

##########
# ROUTES #
##########

# Routes must be added to the Neutron vRouter to point to
# VPN concentrator

resource "openstack_networking_router_routes_v2" "vpn_route_1" {
  provider         = openstack.dfw3
  router_id        = openstack_networking_router_v2.tenant_router.id
  routes {
    destination_cidr = var.vpn_route["destination"]
#    next_hop         = openstack_networking_port_v2.fw-primary-port-outside.fixed_ip[0].ip_address
#    next_hop = "169.254.169.230"
    next_hop         = openstack_networking_port_v2.fw-primary-port-outside.all_fixed_ips[0]
  }
  depends_on       = [openstack_networking_router_interface_v2.tenant-router-interface]
}
