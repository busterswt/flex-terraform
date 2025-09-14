This Terraform example builds the following:

- 1x VyOS VM
- 1x Ubuntu VM
- 1x Neutron router
- Supporting Neutron resources

The VyOS VM is placed off the Neutron router and facilitates
an IPSec VPN tunnel between itself and a remote VPN concentrator.

Traffic from the Ubuntu VM will hairpin through the VyOS VM
thanks to a route(s) placed on the Neutron router for
interesting (vpn) traffic.

The example here configures a route-based tunnel.

```
  tofu init
  tofu apply
```
