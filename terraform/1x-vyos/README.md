This Terraform example builds the following:

- 1x VyOS VM
- 1x Ubuntu VM
- 1x Neutron router
- 1x keypair used for VyOS and VM(s)
- Supporting Neutron resources

![VyOS in OpenStack Flex](assets/vyos.png)

The VyOS VM is placed off the Neutron router and facilitates
an IPSec VPN tunnel between itself and a remote VPN concentrator.

Traffic from the Ubuntu VM will hairpin through the VyOS VM
thanks to a route(s) placed on the Neutron router for
interesting (vpn) traffic.

> [!NOTE]
> The example here configures a route-based tunnel.

To use this Terraform example, install OpenTofu or Terraform and modify
accordingly. Variables can be set in `terraform.tfvars`. Use `terraform.tfvars.example`
as a guide.

```
# Remote subnets for VPN shold be listed here.
# Will also need to update Ansible overrides.yml
vpn_routes = [
  {destination = "10.240.0.0/24"},
  {destination = "192.168.80.0/24"},
  {destination = "172.16.0.0/24"}
]

# VM flavor UUID (gp5.2.4)
vm_flavor = "b5ccd490-b138-4d81-b8c3-c074287708e8"
vm_image = {"uuid":"d8cdd44b-744d-4afa-83ef-ffdbfb259e12", "name":"Ubuntu 24.04 LTS"}

# FW flavor UUID (gp5.2.2)
fw_flavor = "d3a4a3f8-1aa3-4f9e-b08d-9081bb8aea08"
fw_image = {"uuid":"8effec91-f5e3-4860-a1ed-4c7fe2fbcc46", "name":"VyOS 1.4.3"}

# DNS nameservers
dns_nameservers = ["8.8.8.8", "8.8.4.4"]

# External provider network
external_network = {"uuid":"82be3711-cd97-4f7c-8bbd-59f5524a949e", "name":"PUBLICNET"}
```

Run the following to deploy a demo environment with OpenStack Flex:

```
  tofu init
  tofu apply
```

To proceed with the IPSec tunnel configuration, change to the `ansible`
directory and read the README.

```
cd ansible
cat README.md
```
