resource "local_file" "inventory" {
  content = templatefile("${path.module}/templates/inventory.tmpl",
    {
      keypath = "${path.cwd}/id_rsa_mnaio.key"
      fw_float = "${openstack_networking_floatingip_v2.fw-primary-float-outside.address}"
      vm_float = "${openstack_networking_floatingip_v2.server-1-mgmt.address}"
    }
  )
  file_permission = 0600
  filename = "${path.module}/ansible/inventory"
}
