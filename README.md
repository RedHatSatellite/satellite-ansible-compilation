# Satellite Ansible Compilation
### Note: This collection is not officially supported by Red Hat.


Ansible Roles, Playbooks (and Tower Configuration metadata) for installing, configuring and interacting with the Red Hat Satellite. The roles will be created using [foreman-ansible-modules] (https://github.com/theforeman/foreman-ansible-modules) (FAM) where possible.

# Contribution Guidelines

- This collection is a collaborative development environment.
- This collection may not accept all Ansible modules proposed. If you are writing a new module related to Foreman, consider contributing it to [FAM](https://github.com/theforeman/foreman-ansible-modules). For modules that have other source projects, we may request you to open a pull request against respective projects.


## Roles

* The roles written in this collection should be extensible, reusable and idempotent.
* The input variables should be externalized in the `defaults` directory of the roles allowing for easy reuse.
* The variables that are required by the role but not required by user to be modified, should reside in `vars` directory.
* The roles should be compatible with the current (upstream) supported Ansible versions, 2.9+ at the time of writing.
* The roles should be compatible with any Python supported by Ansible upstream (2.7, 3.5, 3.6, 3.7 at the time of writing), however, roles usually don’t require any special Python features (in contrast to modules).
* The roles should be compatible with the latest released version of the [FAM](https://github.com/theforeman/foreman-ansible-modules) collection (v1.0.1 at the time of writing). While defining a dependency on an older FAM release is possible, it is discouraged.
* The roles should attempt to not use `command`, `shell`, or `raw` Ansible modules unless there is no other solution.
* The roles should not use hammer via command/shell or the uri module to talk to the API directly.
* The roles should not duplicate functionality of other existing roles in the same repository.
* The roles should be written to be very specific and not cover a wide-range of functionality in a single role. Break roles up instead of creating large, monolithic roles.
* The roles should have proper metadata (similar to the roles in Galaxy).
* The roles should have example playbook usage of the role covered in the role's `README.md`.


## Playbooks
TODO - Add guidelines.

## Removal of roles
The moderators of this project reserve the right to remove any roles that are captured by a role contributed to [FAM](https://github.com/theforeman/foreman-ansible-modules).

## List of Roles contributed by the community
See [Roles](Roles.md)
