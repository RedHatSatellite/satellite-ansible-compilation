# configure_satellite

Ansible collection to configure satellite.

This collection is also available on [ansible galaxy](https://galaxy.ansible.com/jjaswanson4/configure_satellite).

## Overview
This collection will configure satellite via the [foreman ansible modules](https://theforeman.org/plugins/foreman-ansible-modules).

## Usage
The best way to consume this collection is to set up a requirements.yml:
```yaml
---
collections:
  - jjaswanson4.configure_satellite
```
The collection can also be installed from the command line ad-hoc:
```
ansible-galaxy collection install jjaswanson4.configure_satellite
```

## Examples

## Vars
All vars are defined in a dictionary stored in a vars file included at the playbook level. There are two roles that configure satellite: configure_foreman and configure_katello, that expect variables defined under `foreman` and `katello`.
```yaml
satellite:
  foreman:
  katello:
```
### Foreman Settings ###
Foreman components (such as compute resources, subnets, etc) are defined under `satellite.foreman:`
| Name                     | Description
|--------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------|
| `organizations`          | List of satellite organizations, at least one must be defined with `initial_organization` set to `true`.                                               |
| `locations`              | List of satellite locations, at least one must be defined with `initial_location` set to `true`. Locations can be mapped to zero to many organization. |
| `domains`                | List of domains mapped to zero or many organizations and locations.                                                                                    |
| `subnets`                | List of subnets mapped to zero or many organizations, locations, and domains.                                                                          |
| `compute_resources`      | List of compute resources mapped to zaro or many organizations and locations.                                                                          |
| `compute_profiles`       | List of compute profiles mapped to a compute resource.                                                                                                 |
| `provisioning_templates` | List of provisioning templates mapped to zero to many organizations and locations. Expects a .erb file to exist on the server running ansible.         |
| `partition_tables`       | List of partition tables mapped to zero to many organizations and locations. Expects a .erb file to exist on the server running ansible.               |
| `settings`               | List of foreman settings defined in name:value pairs.                                                                                                  |

- organizations:
```yaml
satellite:
  foreman:
    organizations:
      - name: org_1
        initial_organization: true
      - name: org_2
      - name: org_3
```
- locations:
```yaml
satellite:
  foreman:
    locations:
      - name: loc_1
        initial_location: true
        organizations:
          - name: org_1
          - name: org_2
          - name: org_3
      - name: loc_2
        organizations:
          - name: org_2
      - name: loc_3
        organizations:
          - name: org_2
          - name: org_3
```
- domains:
```yaml
satellite:
  foreman:
    domains:
      - name: domain1.internal.lcl
        description: default dns domain
        organizations:
          - name: org_1
          - name: org_3
        locations:
          - name: loc_1
          - name: loc_3
      - name: domain2.internal.lcl
        description: secondary dns domain
        organizations:
          - name: org_2
        locations:
          - name: loc_2
```
- subnets:
```yaml
satellite:
  foreman:
    subnets:
      - name: test-subnet-192.168.0.0_24
        network: 192.168.0.0
        mask: 255.255.255.0
        gateway: 192.168.0.1
        dns_primary: 192.168.0.10
        dns_secondary: 192.168.1.11
        domains:
          - name: domain1.internal.lcl
        organizations:
          - name: org_1
          - name: org_3
        locations:
          - name: loc_1
          - name: loc_3
      - name: prod-subnet-10.1.0.0_22
        network: 10.1.0.0
        mask: 255.255.252.0
        gateway: 10.1.0.1
        dns_primary: 10.1.0.10
        dns_secondary: 10.1.0.11
        domains:
          - name: domain2.internal.lcl
        organizations:
          - name: org_2
        locations:
          - name: loc_2
```
- compute_resources:
```yaml
satellite:
  foreman:
    compute_resources:
      - name: example_vcenter
        provider: vmware
        provider_params:
          url: vcenter.domain1.interna.lcl
          user: provisioning@vsphere.local
          password: "{{ lookup('file', '/tmp/vcenter-password') }}"
          datacenter: dc1
        organizations:
          - name: org_1
          - name: org_2
        locations:
          - name: loc_1
          - name: loc_3
```
- compute_profiles:
```yaml
satellite:
  foreman:
    compute_profiles:
      - name: general-vm
        compute_resource: example_vcenter
        vm_attrs:
          cpus: 2
          corespersocket: 2
          memory_mb: 2048
          firmware: bios
          cluster: general
          resource_pool: Resources
          path: /Datacenters/dc1/vm
          guest_id: rhel7_64Guest
          hardware_version: vmx-13
          memoryHotAddEnabled: 1
          cpuHotAddEnabled: 1
          add_cdrom: 0
          scsi_controllers:
           - type: ParaVirtualSCSIController
             key: 1000
          interface_attributes:
            0:
              type: VirtualVmxnet3
              network: virtaul-machines
          volumes_attributes:
            0:
              thin: true
              name: Hard disk
              mode: persistent
              controller_key: 1000
              size_gb: 100
              datastore: datastore1
```
- partition_tables:
```yaml
satellite:
  foreman:
    partition_tables:
      - name: RHEL7 Kickstart Partition Table
        file: /tmp/rhel7_kickstart_partition_table.erb
        organizations:
          - name: org_1
          - name: org_2
        locations:
          - name: loc_1
          - name: loc_2
          - name: loc_3
```
- settings:
```yaml
satellite:
  foreman:
    settings:
      - name: default_download_policy
        value: on_demand
      - name: default_proxy_download_policy
        value: on_demand
      - name: unregister_delete_host
        value: true
```
### Katello Settings ###
Katello settings are defined under satellite.katello. A list of organizations containes the organization-specific settings to be set. Below is a commented example vars file.
```yaml
satellite:
  katello:
    - organization_name: org_1 # List of organizations
      state: present
      manifest: /tmp/manifest_satellite-building-testmanifest_20200320T193207Z.zip # Manifest file to be uploaded
      repo_sync_attempts: 3 # How many times to attempt to sync repositories from the CDN
      lifecycle_environments: # List of lifecycle environments
        - name: test
          description: wild west
          prior: Library
        - name: stage
          description: dont test in prod
          prior: test
        - name: prod
          description: big leagues
          prior: stage
      content_views: # List of content views. To create "custom" products, repos, and content credentials, define them.
        - name: cv-epel-rhel8
          repos:
            - repo: Extra Packages for Enterprise Linux 8 Repository
              repo_url: http://download.fedoraproject.org/pub/epel/8/Everything/x86_64
              product: Extra Packages for Enterprise Linux 8
              content_credential: https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-8
              content_credential_name: cc-epel8
          filters:
            - name: include htop from epel8
              filter_type: rpm
              package_name: htop
              inclusion: true
        - name: cv-ansible-rhel8
          description: ansible on RHEL8
          repos:
            - repo: Red Hat Ansible Engine 2 for RHEL 8 x86_64 (RPMs)
              product: Red Hat Ansible Engine
            - repo: Red Hat Ansible Engine 2.8 for RHEL 8 x86_64 (RPMs)
              product: Red Hat Ansible Engine
        - name: cv-appstream-rhel8
          repos:
            - repo: Red Hat Enterprise Linux 8 for x86_64 - AppStream (RPMs)
              product: Red Hat Enterprise Linux for x86_64
              releasever: 8
        - name: cv-server-rhel8
          repos:
            - repo: Red Hat Enterprise Linux 8 for x86_64 - BaseOS (RPMs)
              product: Red Hat Enterprise Linux for x86_64
              releasever: 8
            - repo: Red Hat Satellite Tools 6.6 for RHEL 8 x86_64 (RPMs)
              product: Red Hat Enterprise Linux for x86_64
              content_view: cv-server-rhel8
        - name: cv-supplementary-rhel8
          repos:
            - repo: Red Hat Enterprise Linux 8 for x86_64 - Supplementary (RPMs)
              product: Red Hat Enterprise Linux for x86_64
              releasever: 8
        - name: cv-kickstart-rhel8.2
          repos:
            - repo: Red Hat Enterprise Linux 8 for x86_64 - BaseOS (Kickstart)
              product: Red Hat Enterprise Linux for x86_64
              releasever: 8.2
            - repo: Red Hat Enterprise Linux 8 for x86_64 - AppStream (Kickstart)
              product: Red Hat Enterprise Linux for x86_64
              releasever: 8.2
      composite_content_views:
        - name: composite-rhel8
          description: rhel 8 packages
          auto_publish: false
          component_content_views: # If a specific content view version is desired, then define 'content_view_version', otherwise latest is used
            - name: cv-server-rhel8
            - name: cv-ansible-rhel8
            - name: cv-appstream-rhel8
            - name: cv-supplementary-rhel8
            - name: cv-kickstart-rhel8.2
      activation_keys: # List of activation keys
        - name: ak-virtual
        - name: ak-physical
          subscriptions:
            - subscription_name: Red Hat Enterprise Linux Server with Smart Management, Premium (Physical or Virtual Nodes)
        - name: ak-epel8
          subscriptions:
            - subscription_name: Extra Packages for Enterprise Linux 8
        - name: ak-rhel8-prod
          lifecycle_environment: prod
          content_view: composite-rhel8
          release_version: 8
    - organization_name: org_2
      state: present
      manifest: /tmp/manifest_satellite-building-testmanifest2_20200320T204013Z.zip
      repo_sync_attempts: 3
      lifecycle_environments:
        - name: dev
          description: dev land
          prior: Library
        - name: QA
          description: before prod
          prior: dev
        - name: prod
          description: big leagues
          prior: QA
      content_views:
        - name: cv-ansible-rhel8
          description: ansible on RHEL8
          repos:
            - repo: Red Hat Ansible Engine 2 for RHEL 8 x86_64 (RPMs)
              product: Red Hat Ansible Engine
            - repo: Red Hat Ansible Engine 2.8 for RHEL 8 x86_64 (RPMs)
              product: Red Hat Ansible Engine
        - name: cv-appstream-rhel8
          repos:
            - repo: Red Hat Enterprise Linux 8 for x86_64 - AppStream (RPMs)
              product: Red Hat Enterprise Linux for x86_64
              releasever: 8
        - name: cv-server-rhel8
          repos:
            - repo: Red Hat Enterprise Linux 8 for x86_64 - BaseOS (RPMs)
              product: Red Hat Enterprise Linux for x86_64
              releasever: 8
            - repo: Red Hat Satellite Tools 6.6 for RHEL 8 x86_64 (RPMs)
              product: Red Hat Enterprise Linux for x86_64
              content_view: cv-server-rhel8
        - name: cv-supplementary-rhel8
          repos:
            - repo: Red Hat Enterprise Linux 8 for x86_64 - Supplementary (RPMs)
              product: Red Hat Enterprise Linux for x86_64
              releasever: 8
        - name: cv-kickstart-rhel8.2
          repos:
            - repo: Red Hat Enterprise Linux 8 for x86_64 - BaseOS (Kickstart)
              product: Red Hat Enterprise Linux for x86_64
              releasever: 8.2
            - repo: Red Hat Enterprise Linux 8 for x86_64 - AppStream (Kickstart)
              product: Red Hat Enterprise Linux for x86_64
              releasever: 8.2
      composite_content_views:
        - name: composite-rhel8
          description: rhel 8 packages
          auto_publish: false
          component_content_views:
            - name: cv-server-rhel8
            - name: cv-ansible-rhel8
            - name: cv-appstream-rhel8
            - name: cv-supplementary-rhel8
            - name: cv-kickstart-rhel8.2
      activation_keys:
        - name: ak-virtual
        - name: ak-physical
          subscriptions:
            - subscription_name: Red Hat Enterprise Linux Server with Smart Management, Premium (Physical or Virtual Nodes)
        - name: ak-rhel8-prod
          lifecycle_environment: prod
          content_view: composite-rhel8
          release_version: 8
```
