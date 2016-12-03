#!/bin/bash

set -eu

source ~/shared-variables.sh
: ${GCP_CONCOURSE_ZONE_2:?"Need to set GCP_CONCOURSE_ZONE_2 non-empty"}

if [ ! -f ~/.ssh/bosh ]; then
  ssh-keygen -t rsa -f ~/.ssh/bosh -C bosh -P ""
fi
printf '%s\n' "Setting env vars...."
export ssh_key_path=$HOME/.ssh/bosh
zone=$(curl -sSH "Metadata-Flavor: Google" http://metadata.google.internal/computeMetadata/v1/instance/zone)
printf '%s\n\n'  "Zone = $zone"
export zone=${zone##*/}
export region=${zone%-*}
gcloud config set compute/zone ${zone}
gcloud config set compute/region ${region}
export project_id=`curl -s -H "Metadata-Flavor: Google" http://metadata.google.internal/computeMetadata/v1/project/project-id`

export zone2=$GCP_CONCOURSE_ZONE_2
gcloud config list

pushd $files_dir
erb manifest.yml.erb > manifest.yml
popd
printf '%s\n' "Successfully generated manifest in $files_dir"