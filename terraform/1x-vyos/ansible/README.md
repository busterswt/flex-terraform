```
    pip3 install -r requirements.txt
    ansible-galaxy collection install -r ansible-collection-requirements.yml

    ansible-playbook -i inventory -e @overrides.yml playbooks/add_ipsec_vpn.yml
```
