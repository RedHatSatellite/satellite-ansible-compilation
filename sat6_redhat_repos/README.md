Role Name
=========

This role enables a list of Red Hat CDN-provided repositories on a Satelite 6
instance.

Requirements
------------

This role uses the foreman-ansible-modules collection, which must be installed 
on the machine running the playbook (not necessarily on the Satellite). The
Galaxy collection name is 'theforeman.foreman'.

Role Variables
--------------

satellite_user
	The username used to authenticate to the Satellite

satellite_password
	The password used to authenticate to the Satellite

satellite_host
	The FQDN of the Satellite instance to operate on

organization
	The Organization name to manipulate within the Satellite

cdn_repos
	A list of repository specifications to enable

Dependencies
------------

Depends on the the theforeman.foreman collection.

Example Playbook
----------------

    - hosts: localhost
      roles:
         - sat6_redhat_repos

License
-------

GNU GPL 2.0 or later

Author Information
------------------

John Berninger, john.berninger@redhat.com
