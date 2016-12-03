#!/bin/bash

set -eu

self_dir=$(dirname "${BASH_SOURCE[0]}")
source $self_dir/gcp-prereq-export.sh

export GOOGLE_CREDENTIALS=$(cat /tmp/terraform-bosh.key.json)
