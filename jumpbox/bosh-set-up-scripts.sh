#!/bin/bash

set -eu
: ${GCP_CONCOURSE_ZONE_2:?"Need to set GCP_CONCOURSE_ZONE_2 non-empty"}

env_vars="GCP_CONCOURSE_ZONE_2=$GCP_CONCOURSE_ZONE_2"

source shared-variables.sh

echo $($ssh_bastion "mkdir -p $files_dir")
echo $(cat shared-variables.sh | $ssh_bastion "cat > ~/shared-variables.sh")
echo $(cat manifest.yml.erb | $ssh_bastion "cat > ~/$files_dir/manifest.yml.erb")

echo $($ssh_bastion $env_vars 'bash -s' < bosh-set-up.sh)

