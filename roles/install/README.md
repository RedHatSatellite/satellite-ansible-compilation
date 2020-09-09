Install
===========

This role will install an embedded Satellite 6.6 or greater server

Requirements
------------

Ansible 2.8 or higher
Satellite-ansible-collection
Red Hat Enterprise Linux 7 or equivalent
Valid Red Hat Subscription


Role Variables
--------------
```
satellite_rhn_connect: "{{ lookup('env', 'SATELLITE_RHN_CONNECT') }}"
satellite_admin_username: "{{ lookup('env', 'SATELLITE_USERNAME') }}"
satellite_admin_password: "{{ lookup('env', 'SATELLITE_PASSWORD') }}"
satellite_organization: "{{ lookup('env', 'SATELLITE_ORGANIZATION') }}"
satellite_location: "{{ lookup('env', 'SATELLITE_LOCATION') }}"
satellite_server_url: "https://{{ ansible_fqdn }}"


# satellite install role options:
satellite_options: >-
  --foreman-initial-admin-username "{{ satellite_admin_username }}"
  --foreman-initial-admin-password "{{ satellite_admin_password }}"
  --foreman-initial-organization  "{{ satellite_organization }}"
  --foreman-initial-location  "{{ satellite_location }}"
  --foreman-proxy-dns-managed false
  --foreman-proxy-dns false
  --foreman-proxy-dhcp false
  --foreman-proxy-dhcp-managed false
  --foreman-proxy-tftp false
  --foreman-proxy-tftp-managed false
  --foreman-proxy-puppetca true
  --enable-foreman-plugin-discovery

satellite_settings:
  - name: "default_redhat_download_policy"
    value: "immediate"
  - name: "errata_status_installable"
    value: "true"
```


Dependencies
------------

From Ansible Galaxy
- oasis_roles.system
- theforeman.foreman

Example Playbooks
-----------------

```
---
- name: Satellite
  hosts: satellite
  become: true
  roles:
    - role: install
```

License
-------

[GPLv3](LICENSE)

Author Information
------------------

Cory McKee <cmckee@redhat.com>
Ron Sawyer <rsawyer@redhat.com>
Greg Hellings <ghelling@redhat.com>
