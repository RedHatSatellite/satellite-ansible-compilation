#!/bin/bash
# run_sat.sh [...]
# any argument given is passed to ansible-playbook

# exit on error
set -e

# define default SAT_ENV_FILE if not given
if [[ -z ${SAT_ENV_FILE} ]]
then
  if [[ -f ${HOME}/.sat_env.sh ]]
  then
    SAT_ENV_FILE=${HOME}/.sat_env.sh
  elif [[ -f ./sat_env.sh ]]
  then
    SAT_ENV_FILE=./sat_env.sh
  fi
fi

# source required environmental variables
echo "Sourcing ${SAT_ENV_FILE}"
source ${SAT_ENV_FILE}

# run the plays/roles
echo "Running playbooks/sat_install.yml"
ansible-playbook "$@" playbooks/sat_install.yml
