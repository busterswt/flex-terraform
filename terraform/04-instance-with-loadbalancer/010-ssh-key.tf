# Define ssh to config in instance

resource "openstack_compute_keypair_v2" "user_key" {
  name       = "user-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDisV8DOrk3FEu1/eTjPXFWUAsF98Sj8+fDI0aP0fXlz5A1x0C6LgBpdxn4cjgU2HoHLeK7mdrypHX3H0hQXYYp5Kgv3sXg/KMs9ILf4nig3ZKOOFOjz0P5tULydlpk/SgDTvRJ2+qhFr5aRTTzpkhGctzxjZ7SM0CbqSoArQi5oHB1sXx4ezaMb9Mfl7RFJ0ToJ6O5mimy5Cz0PdfD+GK6KDEOZrlM7ACG6SnXQmaa2rJKKKmo1JBLKbaEb64k1I+sVaT4SMsIkaYzMNGI7R9ZkVpeh1jkjCPNhy/fpro0M4cLFDMzK5fSufEJ9WIwZMpMw5X8rI0YwTr78KBABZPH jame9017@MDR86NMD6R"
}

