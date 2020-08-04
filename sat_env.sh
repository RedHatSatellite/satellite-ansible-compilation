#!/bin/bash
# sat_env.sh
# it's recomended that you copy this file to more secure location before adding
# production values to it such as /root/.sat_env.sh

#export ANSIBLE_DEBUG=1

# --- all installs

# Red Hat Satellite version that is going to be installed
export SATELLITE_VERSION=6.7

# Red Hat Enterprise version that is going to be supported
export SATELLITE_RHELVER=7.7

# Satellite hostname and IP
export SATELLITE_HOSTNAME="changme"
export SATELLITE_DOMAIN="example.com"
export SATELLITE_HOSTIP="x.x.x.x"

# SATELLITE_USERNAME is to set the initial admin user for the satellite
export SATELLITE_USERNAME="myadmin"

# SATELLITE_PASSWORD is set for the initial admin user password
export SATELLITE_PASSWORD="changemenownotlater!"

# SATELLITE_ORGANIZATION is set the initial Organization
export SATELLITE_ORGANIZATION="changeme_org"

# SATELLITE_LOCATION is to set initial Location
export SATELLITE_LOCATION="changeme_loc"

# SATELLITE_ACCOUNT_ID is your Red Hat Account Number required for both
# connected and disconneted installs
export SATELLITE_ACCOUNT_ID='1234567'

# SATELLITE_CONNECT variable is used to set the method of satellite installation
# - connected option is system is register to Red Hat's CDN and has access to
#   the internet
# - disconnect optinon is when the system does not have access to the
#   internet
# - master option is the same has connected but exports the rpm content for a
#   disconnected satellite
# SATELLITE_CONNECT={connected,disconnect, or master}
export SATELLITE_RHN_CONNECT="disconnect"

# work in progress
# export SATELLITE_CERTS_SERVER_CERT=?
# export SATELLITE_CERTS_SERVER_KEY=?
# export SATELLITE_CERTS_SERVER_CA_CERT=?


# --- disconnected installs

# SATELLITE_CONTENT_SOURCE is the path on where the offline rpm repository is
# stored for disconnected installs
export SATELLITE_CONTENT_SOURCE="http://192.168.122.1"

# MANIFEST_NAME is the name of the manifest file to be copied/uploaded
export SATELLITE_MANIFEST_NAME="/opt/manifest_example.zip"


# --- connected installs

# SATELLITE_RHN_AK Activation key is from access.redhat.com for connected
# installs.  To Create an activation key on access.redhat.com:
# https://access.redhat.com/articles/1378093
# export SATELLITE_RHN_AK=Activation key that was created on access.redhat.com

# SATELLITE_RHN_ORG is from access.redhat.com for connected installs
# How to look up organization id on Red Hat's Customer Portal:
# https://access.redhat.com/articles/3047431
# export SATELLITE_RHN_ORG=Activation Keys for Organization ID number

# SATELLITE_POOL_ID=(CHANGE_ME)

# SATELLITE_MANIFEST_UUID is the manifest uuid that is created on
# access.redhat.com
# Manifest FAQ: https://access.redhat.com/articles/229083
# export SATELLITE_MANIFEST_UUID=(CHANGEME-F4K3-UU1D-9h0i-1j2k3l4m5n60)

# User that has permission to register to Red Hat Network
# export SATELLITE_RHN_USER= (access.redhat.com account)

# User Password for the account
# export SATELLITE_RHN_PASSWORD=(access.redhat.com account password)
