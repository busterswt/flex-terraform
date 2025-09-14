resource "local_file" "ssh_key" {
  content = templatefile("${path.module}/templates/id_rsa_mnaio.key.tmpl",
    {
      keypair = openstack_compute_keypair_v2.ssh_key
    }
  )
  file_permission = 0600
  filename = "${path.module}/id_rsa_mnaio.key"
}

