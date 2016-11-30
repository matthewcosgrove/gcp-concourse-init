#!/bin/bash

set -eu

self_dir=$(dirname "${BASH_SOURCE[0]}")

gcloud auth login
gcloud config set project ${projectid}
gcloud config set compute/zone ${zone}
gcloud config set compute/region ${region}
# Create a service account and key
gcloud iam service-accounts create terraform-bosh
gcloud iam service-accounts keys create /tmp/terraform-bosh.key.json \
    --iam-account terraform-bosh@${projectid}.iam.gserviceaccount.com
# Grant the new service account editor access to your project
gcloud projects add-iam-policy-binding ${projectid} \
    --member serviceAccount:terraform-bosh@${projectid}.iam.gserviceaccount.com \
    --role roles/editor
# Make your service account's key available in an environment variable to be used by terraform
export GOOGLE_CREDENTIALS=$(cat /tmp/terraform-bosh.key.json)
