The playbooks here can be used to do things against an OpenStack Flex
environment for demo/proof-of-concept purposes only. The playbooks
may trash your environment and should be modified for production use.

Install pre-requisites:

```
    pip3 install -r requirements.txt
    ansible-galaxy collection install -r ansible-collection-requirements.yml
```

Modify defaults in the `overrides.yml` file, making note of the VPN networks,
endpoint addresses, etc., then run the playbook:

```
    ansible-playbook -i inventory -e @overrides.yml playbooks/add_ipsec_vpn.yml
```

Example configurations for remote endpoints based on the configuration
defined and deployed by this playbook can be found in the `examples`
directory. 

[! NOTE]

cisco_asa_route_based_vpn.txt
