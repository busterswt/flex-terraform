The playbooks here can be used to do things against an OpenStack Flex
environment for demo/proof-of-concept purposes only. The playbooks
may trash your environment and should be modified for production use.

Install pre-requisites:

```
    pip3 install -r requirements.txt
    ansible-galaxy collection install -r ansible-collection-requirements.yml
```

Modify defaults in the `overrides.yml` file, making note of the VPN networks,
endpoint addresses, etc. This information will be used to configure the VyOS
firewall and provide a configuration example for remote device(s):

```
# Set OpenStack cloud (clouds.yaml)
os_cloud: <name of cloud in clouds.yaml>

# VPN Configuration
remote_peer: <remote firewall/vpn endpoint public ip>
local_peer: <local firewall/vpn endpoint public ip>
local_peer_fixed: <local firewall/vpn private ip>

local_networks: <list of local networks for VPN encryption domain>
  - 192.168.40.0/24
remote_networks: <list of remote networks for VPN encryption domain>
  - 10.240.0.0/24
local_vti: <local vti address with cidr>
remote_vti: <remote vti address with cidr>
```

Example:

```
os_cloud: flex-dfw3

remote_peer: 161.47.100.20
local_peer: 50.56.157.196
local_peer_fixed: 169.254.169.230

local_networks:
  - 192.168.40.0/24
remote_networks:
  - 10.240.0.0/24
local_vti: 10.0.0.1/30
remote_vti: 10.0.0.2/30
```

Then run the playbook:

```
    ansible-playbook -i inventory -e @overrides.yml playbooks/add_ipsec_vpn.yml
```

Example configurations for remote endpoints based on the configuration
defined and deployed by this playbook can be found in the `examples`
directory.
