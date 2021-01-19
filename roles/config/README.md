CONFIG
======

Description
-----------
Config role to install Satellite configuration data:
* Create host collections
* Create lifecycle environments
* Create content and composite content views, publish if changed
* Create activation keys
* Create subnets
* Create domains
* Create hostgroups
* Create compute nodes - TODO
* Create compute resources - TODO
* Create Ansible roles to configure VMs - TODO
* Create hosts - TODO


Requirements
------------

Ansible 2.8 or higher
Satellite-ansible-collection
Red Hat Enterprise Linux 7 or equivalent
Valid Red Hat Subscription
A fully installed Satellite version 6.6 or higher
Enabled and sync'd repos


Role Variables
--------------

```yaml
# defaults file for sat_config
# yamllint disable-line rule:line-length
satellite_admin_username: "{{ lookup('env', 'SATELLITE_USERNAME') | mandatory }}"
# yamllint disable-line rule:line-length
satellite_admin_password: "{{ lookup('env', 'SATELLITE_PASSWORD') | mandatory }}"
# yamllint disable-line rule:line-length
satellite_organization: "{{ lookup('env', 'SATELLITE_ORGANIZATION') | mandatory }}"
satellite_location: "{{ lookup('env', 'SATELLITE_LOCATION') | mandatory }}"
satellite_version: "{{ lookup('env', 'SATELLITE_VERSION') | mandatory }}"
satellite_rhelver: "{{ lookup('env', 'SATELLITE_RHELVER') | mandatory }}"
satellite_fqdn: "{{ ansible_fqdn }}"
satellite_server_url: "https://{{ ansible_fqdn }}"
satellite_server_basearch: "x86_64"
satellite_prod_lifecycle_env: "Production"
satellite_domain: "{{ ansible_domain }}"
satellite_mgmtsubnet: "ManagementNetwork"
satellite_network: "{{ ansible_default_ipv4.network }}"
satellite_mask: "{{ ansible_default_ipv4.netmask }}"
satellite_dhcp_fromip: "192.168.122.100"
satellite_dhcp_toip: "192.168.122.150"
satellite_dhcp_gateway: "{{ ansible_default_ipv4.gateway }}"  # 192.168.122.1
satellite_dhcp_nameservers: "{{ ansible_dns.nameservers[0] }}"  # 192.168.122.1
satellite_dhcp_domain: "{{ ansible_domain }}"  # example.com
satellite_partition_table_name: "Kickstart default"
satellite_operatingsystem: "RedHat {{ satellite_rhelver }}"
# yamllint disable-line rule:line-length
satellite_kickstart_repository: "Red Hat Enterprise Linux 7 Server Kickstart x86_64 {{ satellite_rhelver }}"
satellite_state: "present"
satellite_auto_publish: "true"

# satellite_organizations:
#   - name: Default
#     description: default organization

# satellite_locations:
#   - name: Default
#     description: default location

# satellite_host_collections:
#   - name: KVMHOSTS_HC
#     description: "physical KVM servers"

# satellite_content_views:
#   - name: RHEL7Ansible_CV
#     repositories:
#       # yamllint disable-line rule:line-length
#       - name: "Red Hat Ansible Engine 2.8 RPMs for Red Hat Enterprise Linux 7 Server x86_64"
#         product: "Red Hat Ansible Engine"

#   - name: RHEL7SatTools_CV
#     repositories:
#       - name: "Red Hat Satellite Tools 6.7 for RHEL 7 Server RPMs x86_64"
#         product: "Red Hat Enterprise Linux Server"

#   - name: RHEL7Server_CV
#     repositories:
#       # yamllint disable-line rule:line-length
#       - name: "Red Hat Enterprise Linux 7 Server RPMs x86_64 {{ satellite_rhelver }}"
#         product: "Red Hat Enterprise Linux Server"

#   - name: RHEL7Extras_CV
#     repositories:
#       - name: "Red Hat Enterprise Linux 7 Server - Extras RPMs x86_64"
#         product: "Red Hat Enterprise Linux Server"

#   - name: RHEL7Optional_CV
#     repositories:
#       # yamllint disable-line rule:line-length
#       - name: "Red Hat Enterprise Linux 7 Server - Optional RPMs x86_64 {{ satellite_rhelver }}"
#         product: "Red Hat Enterprise Linux Server"

#   - name: RHEL7SC_CV
#     repositories:
#       # yamllint disable-line rule:line-length
#       - name: "Red Hat Software Collections RPMs for Red Hat Enterprise Linux 7 Server x86_64 {{ satellite_rhelver }}"
#         product: "Red Hat Software Collections (for RHEL Server)"

# satellite_composite_content_views:
#   - name: RHEL7_KVM_CCV
#     components:
#       - content_view: RHEL7Server_CV
#         latest: true
#       - content_view: RHEL7Ansible_CV
#         latest: true
#       - content_view: RHEL7Extras_CV
#         latest: true
#       - content_view: RHEL7Optional_CV
#         latest: true
#       - content_view: RHEL7SatTools_CV
#         latest: true

# satellite_activation_keys:
#   - name: KVM_AK
#     lifecycle_environment: "{{ satellite_prod_lifecycle_env }}"
#     content_view: RHEL7_KVM_CCV
#     host_collections:
#       - KVMHOSTS_HC
#     subscriptions:
#       # yamllint disable-line rule:line-length
#       - name: "CHANGEME"
#       # yamllint disable-line rule:line-length
#       #- name: "Red Hat Enterprise Linux Server with Smart Management, Standard (Physical or Virtual Nodes)"
#     content_overrides:
#       - label: rhel-7-server-ansible-2.8-rpms
#         override: enabled
#       - label: rhel-7-server-extras-rpms
#         override: enabled
#       - label: rhel-7-server-optional-rpms
#         override: enabled
#       - label: rhel-7-server-satellite-tools-{{ satellite_version }}-rpms
#         override: enabled
#     auto_attach: true
#     release_version: 7Server
#     service_level: Standard

# satellite_subnets:
#   - name: "{{ satellite_mgmtsubnet }}"
#     description: "{{ satellite_mgmtsubnet }}"
#     locations:
#       - "{{ satellite_location }}"
#     organizations:
#       - "{{ satellite_organization }}"
#     network: "{{ satellite_network }}"
#     mask: "{{ satellite_mask }}"
#     gateway: "{{ satellite_dhcp_gateway }}"
#     from_ip: "{{ satellite_dhcp_fromip }}"
#     to_ip: "{{ satellite_dhcp_toip }}"
#     domains:
#       - "{{ satellite_domain }}"
#     boot_mode: "DHCP"
#     ipam: "DHCP"
#     dhcp_proxy: "{{ satellite_fqdn }}"
#     dns_proxy: "{{ satellite_fqdn }}"
#     discovery_proxy: "{{ satellite_fqdn }}"
#     httpboot_proxy: "{{ satellite_fqdn }}"
#     tftp_proxy: "{{ satellite_fqdn }}"
#     remote_execution_proxies:
#       - "{{ satellite_fqdn }}"
#     server_url: "{{ satellite_server_url }}"

# satellite_domains:
#   - name: "{{ satellite_domain }}"
#     description: "{{ satellite_domain }}"
#     locations:
#       - "{{ satellite_location }}"
#     organizations:
#       - "{{ satellite_organization }}"
#     state: present

# satellite_hostgroups:
#   - name: "BASELINE"
#     description: "BASELINE"
#     architecture: "{{ satellite_server_basearch }}"
#     operatingsystem: "{{ satellite_operatingsystem }}"
#     lifecycle_environment: "{{ satellite_prod_lifecycle_env }}"
#     content_source: "{{ satellite_fqdn }}"
#     content_view: 'RHEL7Server_CV'
#     kickstart_repository: "{{ satellite_kickstart_repository }}"
#     ptable: "{{ satellite_partition_table_name }}"
#     environment: "production"
#     organization: "{{ satellite_organization }}"
#     organizations:
#       - "{{ satellite_organization }}"
#     locations:
#       - "{{ satellite_location }}"
#     domain: "{{ satellite_domain }}"
#     subnet: "{{ satellite_mgmtsubnet }}"
#     parameters:
#       - name: allowusbstorage
#         value: false
#       - name: pass_max_days
#         value: 60
#       - name: pass_min_days
#         value: 1
#       - name: pass_min_len
#         value: 15
#     state: present

#   - name: "VM"
#     parent: "BASELINE"
#     organization: "{{ satellite_organization }}"
#     state: present

#   - name: "KVM"
#     parent: "BASELINE"
#     organization: "{{ satellite_organization }}"
#     state: present

#   - name: "SOMEAPP"
#     parent: "BASELINE/VM/SOMEAPP"
#     organization: "{{ satellite_organization }}"
#     state: present
```

Dependencies
------------

From Ansible Galaxy
- oasis_roles.system
- theforeman.foreman

Example Playbook
----------------
```
---
    - hosts: servers
      roles:
         - { role: config }
```

License
-------

[GPLv3](LICENSE)

Author Information
------------------

Cory McKee <cmckee@redhat.com>
Ron Sawyer <rsawyer@redhat.com>
Greg Hellings <ghelling@redhat.com>
