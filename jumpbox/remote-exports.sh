#!/bin/bash

set -eu
: ${GCP_CONCOURSE_COMMON_PASSWORD:?"Need to set GCP_CONCOURSE_COMMON_PASSWORD non-empty"}
: ${GCP_CONCOURSE_ATC_PASSWORD:?"Need to set GCP_CONCOURSE_ATC_PASSWORD non-empty"}
: ${GCP_CONCOURSE_ZONE_2:?"Need to set GCP_CONCOURSE_ZONE_2 non-empty"}
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
export external_ip=`gcloud compute addresses describe concourse | grep ^address: | cut -f2 -d' '`
export director_uuid=`bosh status --uuid 2>/dev/null`
export common_password=$GCP_CONCOURSE_COMMON_PASSWORD
export atc_password=$GCP_CONCOURSE_ATC_PASSWORD
echo IP $external_ip
