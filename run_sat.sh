#!/bin/bash
# run_sat.sh

# source required environmental variables
if [[ -f /root/.sat_env.sh ]]
then
  echo "/root/.sat_env.sh"
  source /root/.sat_env.sh
else
  echo "./sat_env.sh"
  source ./sat_env.sh
fi

# run the plays/roles
echo "playbooks/sat_install.yml"
ansible-playbook playbooks/sat_install.yml
