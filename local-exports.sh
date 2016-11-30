#!/bin/bash

set -eu
echo "Exporting variables.."
export projectid=concourse-mc
export zone=europe-west1-d
export region=europe-west1
export zone2=europe-west1-c
echo e.g. $(env | grep projectid)
export GOOGLE_CREDENTIALS=$(cat /tmp/terraform-bosh.key.json)
