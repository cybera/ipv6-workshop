#! /bin/bash

#
# Grabs the IPs of your local VM and sets our used variables for them.
#

export IP4_WKSHP=`/sbin/ifconfig | grep '134.87' | awk '{ print $2 }' | cut -c 6-`
export IP6_WKSHP=`/sbin/ifconfig | grep '2607' | awk '{ print $3 }' | rev | cut -c 4- | rev`
