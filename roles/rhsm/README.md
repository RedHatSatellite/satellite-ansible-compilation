RHSM
=====

Description
-----------

This role will remove all repos in /etc/yum.repos.d directory other than
redhat.repo

For a connected install - register a system using `redhat_subscription` ansible
module using either an activation key or username/password to access 
access.redhat.com

or 

For a disconnected install - create an /etc/yum.repos.d/disconnected.repo
pointing at a local content source to allow satellite to be installed and 
sync'd

Then enable repos require to install Satellite


Requirements
------------

Ansible 2.8 or higher
Red Hat Enterprise Linux 7 or equivalent
Valid Red Hat Subscriptions
Activation key or username/password for a connected install
Locally available content source via http for a disconnected install

Role Variables
--------------

satellite_rhn_activation_key: "{{ lookup('env', 'SATELLITE_RHN_AK') }}"
satellite_rhn_org: "{{ lookup('env', 'SATELLITE_RHN_ORG')}}"
satellite_rhn_pool_id: "{{ lookup('env', 'SATELLITE_RHN_POOL_ID')}}"
satellite_rhn_connect: "{{ lookup('env', 'SATELLITE_RHN_CONNECT') }}"
satellite_rhn_username: "{{ lookup('env', 'SATELLITE_RHN_USER') }}"
satellite_rhn_password: "{{ lookup('env', 'SATELLITE_RHN_PASSWORD') }}"
satellite_version: "{{ lookup('env', 'SATELLITE_VERSION') }}"
satellite_rhelver: "{{ lookup('env', 'SATELLITE_RHELVER') | mandatory }}"
satellite_content_source: "{{ lookup('env', 'SATELLITE_CONTENT_SOURCE') }}"


Dependencies
------------

Privilege escalation (sudo) is required for this role to function.


Example Playbooks
-----------------

Update sat_env.sh with appropriate values

```yaml
- hosts: servers
  roles:
    - role: rhsm
```

License
-------

[GPLv3](LICENSE)


Author Information
------------------

Cory McKee <cmckee@redhat.com>
Ron Sawyer <rsawyer@redhat.com>
