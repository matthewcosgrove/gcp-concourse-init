#!/bin/bash

set -eu
: ${GCP_CONCOURSE_ZONE_2:?"Need to set GCP_CONCOURSE_ZONE_2 non-empty"}

env_vars="GCP_CONCOURSE_ZONE_2=$GCP_CONCOURSE_ZONE_2"

self_dir=$(dirname "${BASH_SOURCE[0]}")
source $self_dir/shared-variables.sh

echo $($ssh_bastion "mkdir -p $files_dir")
echo $(cat shared-variables.sh | $ssh_bastion "cat > ~/shared-variables.sh")
echo $(cat remote/manifest.yml.erb | $ssh_bastion "cat > ~/$files_dir/manifest.yml.erb")

echo $($ssh_bastion $env_vars 'bash -s' < remote/bosh-set-up.sh)

