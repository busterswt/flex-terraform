# Rackspace Flex POC

This repository stores Terraform code that can be used to
demonstrate functionality within Rackspace OpenStack Flex
environments.

## Authentication

On your workstation, create a file at `~/.config/openstack/clouds.yaml`
that can be referenced by the `openstack` command line
client, like so:

```
cache:
  auth: true
clouds:
  flex-dfw3:
    auth:
      auth_url: https://keystone.api.dfw3.rackspacecloud.com/v3
      project_name: <hexadecimal project name>
      project_domain_name: rackspace_cloud_domain
      username: <username>
      password: <apikey>
      user_domain_name: rackspace_cloud_domain
    region_name: DFW3
    interface: public
    identity_api_version: "3"
```

Client operations can then be executed by specifying the `--os-cloud`
and `--os-region` flags, or by exporting the OS_CLOUD
environment variable, like so:

```
With export:

(openstackclient) {8:58}~ export OS_CLOUD=flex-dfw3
(openstackclient) {8:58}~ openstack image list
+--------------------------------------+------------------------------------------+--------+
| ID                                   | Name                                     | Status |
+--------------------------------------+------------------------------------------+--------+
| 87ba11c6-898a-4c91-8148-bfd443fbcb9b | AlmaLinux 8                              | active |
| 9be6b2e7-5949-40e5-857b-6752f9d33d26 | AlmaLinux 9                              | active |
| fee5af21-c73e-46c3-b38a-7b921ea5a20f | CentOS-6-x86_64-GenericCloud-1907        | active |
| 08c6b7ff-6c1f-4c53-9ff1-8c53c15a007a | CentOS-6-x86_64-GenericCloud-20141129_01 | active |
| 4c2af401-9da3-4cb3-8701-b36bbdc359a9 | Debian 11                                | active |
| d09ba030-536a-4034-b372-05d5d5752465 | Debian 12                                | active |
| 2a1342ea-9913-4d9c-bc72-3aab2ae567db | Oracle Linux 8                           | active |
| 854f1b7f-b94c-4461-9350-8a4dbce5ba15 | Oracle Linux 9                           | active |
| ed848eab-74bd-42c8-8e6a-c2599781c636 | Palo Alto VM (KVM) 10.2.10-h14           | active |
| e05b21a9-d235-4ec7-9ef7-3f61ae24e22a | Red Hat Enterprise Linux 8               | active |
| 334e3d5d-47ca-469c-af8b-3bf8303deb94 | Red Hat Enterprise Linux 9               | active |
| ab43f949-8a38-4387-a439-869230b408b4 | Rocky Linux 8                            | active |
| 923b8560-a685-47b8-a6e3-fa62e2838d22 | Rocky Linux 9                            | active |
| 5abfcd0b-8647-4d16-89fc-488876900cfb | Ubuntu 20.04                             | active |
| c9fccb13-e23f-44cc-9792-2d2d4428a45f | Ubuntu 22.04                             | active |
| ec458631-309a-4b7d-846c-cd2ccc601137 | Ubuntu 24.04                             | active |
| 95c8f6c9-fd51-436a-aef3-6d251fbaebb9 | Windows Server 2016                      | active |
| afc3674c-2fab-4214-89fb-d10bc92e37ce | Windows Server 2016 with SQL 2016 Std    | active |
| 9648f5f4-ede1-463a-9bdd-909f5b460b1b | Windows Server 2016 with SQL 2016 Web    | active |
| e92829e1-1c41-416d-917c-6a05eb274e9c | Windows Server 2019                      | active |
| e02594e4-6caa-4da0-89aa-f7ab4f1fed31 | Windows Server 2019 with SQL 2019 Std    | active |
| 368dc2c8-6624-49e1-9ac1-27234af96877 | Windows Server 2019 with SQL 2019 Web    | active |
| a8e602a7-4c8f-4b7d-9125-22ad3fbe6e60 | Windows Server 2022                      | saving |
| 8c037926-cd16-4fd4-9ad5-aadbd3fe7e48 | Windows Server 2022 with SQL 2022 Std    | active |
| b83de589-a17f-4422-8b3b-6fe871be2c51 | Windows Server 2022 with SQL 2022 Web    | active |
| fca3ef17-16cb-487b-9223-d1239c196d77 | Windows Server 2025                      | active |
| 4594a0b7-d2ce-437f-b990-c5e53c6b47b1 | Windows Server 2025 with SQL 2022 Std    | active |
| b6102be5-1128-4810-b3a2-883c6f9a87d4 | Windows Server 2025 with SQL 2022 Web    | active |
+--------------------------------------+------------------------------------------+--------+
```

```
Without export:

(openstackclient) {8:58}~ ➭ openstack --os-cloud flex-dfw3 image list
+--------------------------------------+------------------------------------------+--------+
| ID                                   | Name                                     | Status |
+--------------------------------------+------------------------------------------+--------+
| 87ba11c6-898a-4c91-8148-bfd443fbcb9b | AlmaLinux 8                              | active |
| 9be6b2e7-5949-40e5-857b-6752f9d33d26 | AlmaLinux 9                              | active |
| fee5af21-c73e-46c3-b38a-7b921ea5a20f | CentOS-6-x86_64-GenericCloud-1907        | active |
| 08c6b7ff-6c1f-4c53-9ff1-8c53c15a007a | CentOS-6-x86_64-GenericCloud-20141129_01 | active |
| 4c2af401-9da3-4cb3-8701-b36bbdc359a9 | Debian 11                                | active |
| d09ba030-536a-4034-b372-05d5d5752465 | Debian 12                                | active |
| 2a1342ea-9913-4d9c-bc72-3aab2ae567db | Oracle Linux 8                           | active |
| 854f1b7f-b94c-4461-9350-8a4dbce5ba15 | Oracle Linux 9                           | active |
| ed848eab-74bd-42c8-8e6a-c2599781c636 | Palo Alto VM (KVM) 10.2.10-h14           | active |
| e05b21a9-d235-4ec7-9ef7-3f61ae24e22a | Red Hat Enterprise Linux 8               | active |
| 334e3d5d-47ca-469c-af8b-3bf8303deb94 | Red Hat Enterprise Linux 9               | active |
| ab43f949-8a38-4387-a439-869230b408b4 | Rocky Linux 8                            | active |
| 923b8560-a685-47b8-a6e3-fa62e2838d22 | Rocky Linux 9                            | active |
| 5abfcd0b-8647-4d16-89fc-488876900cfb | Ubuntu 20.04                             | active |
| c9fccb13-e23f-44cc-9792-2d2d4428a45f | Ubuntu 22.04                             | active |
| ec458631-309a-4b7d-846c-cd2ccc601137 | Ubuntu 24.04                             | active |
| 95c8f6c9-fd51-436a-aef3-6d251fbaebb9 | Windows Server 2016                      | active |
| afc3674c-2fab-4214-89fb-d10bc92e37ce | Windows Server 2016 with SQL 2016 Std    | active |
| 9648f5f4-ede1-463a-9bdd-909f5b460b1b | Windows Server 2016 with SQL 2016 Web    | active |
| e92829e1-1c41-416d-917c-6a05eb274e9c | Windows Server 2019                      | active |
| e02594e4-6caa-4da0-89aa-f7ab4f1fed31 | Windows Server 2019 with SQL 2019 Std    | active |
| 368dc2c8-6624-49e1-9ac1-27234af96877 | Windows Server 2019 with SQL 2019 Web    | active |
| a8e602a7-4c8f-4b7d-9125-22ad3fbe6e60 | Windows Server 2022                      | saving |
| 8c037926-cd16-4fd4-9ad5-aadbd3fe7e48 | Windows Server 2022 with SQL 2022 Std    | active |
| b83de589-a17f-4422-8b3b-6fe871be2c51 | Windows Server 2022 with SQL 2022 Web    | active |
| fca3ef17-16cb-487b-9223-d1239c196d77 | Windows Server 2025                      | active |
| 4594a0b7-d2ce-437f-b990-c5e53c6b47b1 | Windows Server 2025 with SQL 2022 Std    | active |
| b6102be5-1128-4810-b3a2-883c6f9a87d4 | Windows Server 2025 with SQL 2022 Web    | active |
+--------------------------------------+------------------------------------------+--------+
```
