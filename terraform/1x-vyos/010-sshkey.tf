# Define ssh to config in instance

resource "openstack_compute_keypair_v2" "ssh_key" {
  provider    = openstack.dfw3
  name        = "${join("-",["${random_pet.pet_name.id}","ssh-key"])}"
}
