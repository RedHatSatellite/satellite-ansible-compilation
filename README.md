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

## HOWTO

### How to create a Satellite server

* copy [sat_env.sh](sat_env.sh) to your own version, e.g. `~/.sat_env.sh` (the default) or `sat_env.myown.sh` (will be ignored by Git).
* adapt the environment definition file to your needs
* create an inventory... TODO add more information
* if you didn't use the default location, export the variable `SAT_ENV_FILE` pointing to your environment file, e.g. `export SAT_ENV_FILE=./sat_env.myown.sh`.
* call `./run_sat.sh` with the parameters required to make ansible-playbook work, e.g. with `-K` for sudo rights and/or `-i inventory.myown.d` to point at your inventory.

> **TIP** if the installation of Satellite fails (meaning, during the handler task installing Satellite), then fix and repeat adding `-e satellite_force_install=true` so that the pre-existing script is removed and restarted.
