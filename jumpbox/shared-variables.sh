#!/bin/bash

set -eu

export ssh_bastion="gcloud compute ssh bosh-bastion-concourse -- "
export files_dir="google-bosh-director"
