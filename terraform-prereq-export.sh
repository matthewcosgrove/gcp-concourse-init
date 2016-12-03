#!/bin/bash

set -eu

: ${GCP_CONCOURSE_PROJECT_ID:?"Need to set GCP_CONCOURSE_PROJECT_ID non-empty"}
: ${GCP_CONCOURSE_REGION:?"Need to set GCP_CONCOURSE_REGION non-empty"}
: ${GCP_CONCOURSE_ZONE_1:?"Need to set GCP_CONCOURSE_ZONE_1 non-empty"}
: ${GCP_CONCOURSE_ZONE_2:?"Need to set GCP_CONCOURSE_ZONE_2 non-empty"}
export projectid=$GCP_CONCOURSE_PROJECT_ID
export region=$GCP_CONCOURSE_REGION
export zone=$GCP_CONCOURSE_ZONE_1
export zone2=$GCP_CONCOURSE_ZONE_2

export GOOGLE_CREDENTIALS=$(cat /tmp/terraform-bosh.key.json)
