# Create firewall instance
resource "openstack_compute_instance_v2" "fw-primary" {
  provider    = openstack.dfw3
  name        = "${join("-",["${random_pet.pet_name.id}","fw-primary"])}"
  image_id    = var.fw_image["uuid"]
  flavor_id   = var.fw_flavor
  key_pair    = openstack_compute_keypair_v2.ssh_key.name
#  user_data   = file("scripts/cloud-init.yaml")
  config_drive = true
  network {
    port = openstack_networking_port_v2.fw-primary-port-outside.id
  }
}

# Create network port
resource "openstack_networking_port_v2" "fw-primary-port-outside" {
  provider    = openstack.dfw3
  name           = "${join("-",["${random_pet.pet_name.id}","fw-primary-port-outside"])}"
  network_id     = openstack_networking_network_v2.transit_network.id
  admin_state_up = true
  security_group_ids = [openstack_networking_secgroup_v2.fw_outside.id]
  port_security_enabled = true
  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.transit_network.id
  }
  allowed_address_pairs {
    ip_address = var.vpn_route["destination"]
  }
}

#### Floating IPs ####

resource "openstack_networking_floatingip_v2" "fw-primary-float-outside" {
  provider    = openstack.dfw3
  pool         = var.external_network["name"]
}

resource "openstack_networking_floatingip_associate_v2" "fw-primary-float-outside-associate" {
  provider    = openstack.dfw3
  floating_ip = "${openstack_networking_floatingip_v2.fw-primary-float-outside.address}"
  port_id     = openstack_networking_port_v2.fw-primary-port-outside.id

  depends_on = [ openstack_networking_router_interface_v2.tenant-router-interface ]
}
