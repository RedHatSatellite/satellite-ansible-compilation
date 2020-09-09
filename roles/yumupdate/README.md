Role Name
=========

Description
-----------

Removes a list of packages, adds a list of packages, checks if a full yum
update is required, and if so yum updates then reboots the server


Requirements
------------

Ansible 2.8 or higher
Red Hat Enterprise Linux 7 or equivalent
Valid Red Hat Subscriptions


Role Variables
--------------

satellite_add_pkgs:
  - screen
  - unzip
  - ipa-client
  - tmux

satellite_remove_pkgs:
  - iwl7265-firmware


Dependencies
------------

Privilege escalation (sudo) is required for this role to function.


Example Playbook
----------------

```yaml
- hosts: servers
  roles:
    - role: yumupdate
```


License
-------

[GPLv3](LICENSE)


Author Information
------------------

Cory McKee <cmckee@redhat.com>
Ron Sawyer <rsawyer@redhat.com>
