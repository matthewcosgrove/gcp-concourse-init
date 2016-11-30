#!/bin/bash

set -eu

export GOOGLE_CREDENTIALS=$(cat /tmp/terraform-bosh.key.json)
