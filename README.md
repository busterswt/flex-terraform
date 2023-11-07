# Rackspace Flex POC

This repository stores Terraform code that can be used to demonstrate functionality within the Rackspace OpenStack Flex environment.

## Authentication

On your workstation, create a file at `~/.config/openstack/clouds.yaml` that can be referenced by the `openstack` command line client, like so:

```
cache:
  auth: true
clouds:
  ospcv2-flex:
    auth:
      auth_url: https://identity-ospcv2-staging.ohthree.com:5000/v3
      project_name: <DDI>_Flex
      project_domain_name: rackspace_cloud_domain
      username: <username>
      password: <apikey>
      user_domain_name: rackspace_cloud_domain
    region_name: IAD3,ORD1,DFW3
    interface: public
    identity_api_version: "3"
```

Client operations can then be executed by specifying the `--os-cloud` and `--os-region` flags, like so:

```
root@ospc:~# openstack --os-cloud ospcv2-flex --os-region IAD3 image list
+--------------------------------------+---------------------------------------+--------+
| ID                                   | Name                                  | Status |
+--------------------------------------+---------------------------------------+--------+
| 3e1e6eae-f266-4e7f-b594-1028b137442d | PA-VM-KVM-11.0.2-image                | active |
| 3d15bfc3-5967-4680-bc93-fe7538b6101c | cisco-asav-9-18-35-55-image           | active |
| 97257e32-5518-42bf-a83f-1b399d8503c3 | ospcv2-alma-linux-9-cloud-image       | active |
| e3cf0ce6-29df-45b5-8bc2-347513099c96 | ospcv2-debian-10-buster-cloud-image   | active |
| af59141d-6cf6-41bc-b9d7-d9273b9227ea | ospcv2-rocky-linux-8-cloud-image      | active |
| 7ea6dddb-b0fb-4f28-ab0c-bb569fddf49e | ospcv2-rocky-linux-9-cloud-image      | active |
| da5b3ba8-fb03-4951-8100-8db7f843245b | ospcv2-ubuntu-20.04-focal-cloud-image | active |
| 763025c8-ca43-442e-8fb3-66ed564395df | ospcv2-ubuntu-22.04-jammy-cloud-image | active |
+--------------------------------------+---------------------------------------+--------+
```
