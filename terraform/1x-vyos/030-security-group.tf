###################
# Security Groups #
###################

resource "openstack_networking_secgroup_v2" "fw_outside" {
  provider    = openstack.dfw3
  name        = "fw_outside"
  description = "Security Group for Firewall Outside Interface"
}

resource "openstack_networking_secgroup_v2" "tenant_vms" {
  provider    = openstack.dfw3
  name        = "tenant_vms"
  description = "Security Group for VMs"
}

########################
# Security Group Rules #
########################

# Firewall/VPN Concentrator

resource "openstack_networking_secgroup_rule_v2" "all-icmp" {
  provider  = openstack.dfw3
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "icmp"
  remote_ip_prefix = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.fw_outside.id}"
}

resource "openstack_networking_secgroup_rule_v2" "all-ssh" {
  provider  = openstack.dfw3
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "tcp"
  port_range_min = 22
  port_range_max = 22
  remote_ip_prefix = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.fw_outside.id}"
}

resource "openstack_networking_secgroup_rule_v2" "all-ipv4" {
  provider  = openstack.dfw3
  direction = "ingress"
  ethertype = "IPv4"
  remote_ip_prefix = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.fw_outside.id}"
}

# Servers/VMs

resource "openstack_networking_secgroup_rule_v2" "servers-all-icmp" {
  provider  = openstack.dfw3
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "icmp"
  remote_ip_prefix = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.tenant_vms.id}"
}

resource "openstack_networking_secgroup_rule_v2" "servers-all-ssh" {
  provider  = openstack.dfw3
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "tcp"
  port_range_min = 22
  port_range_max = 22
  remote_ip_prefix = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.tenant_vms.id}"
}

resource "openstack_networking_secgroup_rule_v2" "tenant-all-https" {
  provider  = openstack.dfw3
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "tcp"
  port_range_min = 443
  port_range_max = 443
  remote_ip_prefix = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.tenant_vms.id}"
}
