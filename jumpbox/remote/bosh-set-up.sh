#!/bin/bash

set -eu

: ${GCP_CONCOURSE_ZONE_2:?"Need to set GCP_CONCOURSE_ZONE_2 non-empty"}

self_dir=$(dirname "${BASH_SOURCE[0]}")

if [ ! -f ~/.ssh/bosh ]; then
  ssh-keygen -t rsa -f ~/.ssh/bosh -C bosh -P ""
fi

echo Setting env vars
export ssh_key_path=$HOME/.ssh/bosh
zone=$(curl -sSH "Metadata-Flavor: Google" http://metadata.google.internal/computeMetadata/v1/instance/zone)
echo Zone = $zone
export zone=${zone##*/}
export region=${zone%-*}
gcloud config set compute/zone ${zone}
gcloud config set compute/region ${region}
export project_id=`curl -s -H "Metadata-Flavor: Google" http://metadata.google.internal/computeMetadata/v1/project/project-id`

export zone2=$GCP_CONCOURSE_ZONE_2
gcloud config list

echo $self_dir
source ~/shared-variables.sh
echo $files_dir
cd google-bosh-director
erb manifest.yml.erb > manifest.yml
