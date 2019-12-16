# Satellite Ansible Roles
### Note: The roles here are not officially supported by Red Hat.

Ansible Roles for interacting with the Red Hat Satellite API, combining different modules into workflows. The roles will be created using [foreman-ansible-modules](https://github.com/theforeman/foreman-ansible-modules) (FAM).

# What this project is not?
- This is not an Ansible Collection. The roles present here are standalone roles.
- This will not be published in Ansible Galaxy.
- This project will not accept Ansible modules. If you are writing a new module, consider contributing it to FAM.
- The roles here will not be shipped with FAM. If you like your role to be shipped with foreman-ansible-modules, consider contributing it to FAM using the rules listed in [Link to be updated later] (https://github.com/theforeman/foreman-ansible-modules/issues/646)

## Rules for contributing Roles to this project

* The use cases supported by the roles should be beneficial for many users.
* Input variables externalized in `defaults` folder of roles for easy reuse.
* The roles should be compatible with the currently (upstream) supported Ansible versions, 2.7+ at the time of writing.
* The roles should be compatible with any Python supported by Ansible upstream (2.7, 3.5, 3.6, 3.7 at the time of writing), however, roles usually don’t require any special Python features (in contrast to modules).
* The roles should be compatible with the latest released version of the FAM collection (0.3.0 at the time of writing). While defining a dependency on an older FAM release is possible, it is discouraged.
* The roles shall not use hammer via command/shell or the uri module to talk to the API directly.
* The roles should not duplicate functionality of other existing roles in the same repository.
* The roles should be in the form that is ready to be pushed to Galaxy.

## Removal of roles
The moderators of this project reserve the right to remove any roles that are captured by a role contributed to FAM.
