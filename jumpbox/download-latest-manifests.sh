#!/bin/bash

set -eu

self_dir=$(dirname "${BASH_SOURCE[0]}")
pushd $self_dir
wget -O cloud-config-latest.yml https://raw.githubusercontent.com/cloudfoundry-incubator/bosh-google-cpi-release/master/docs/concourse/cloud-config.yml
wget -O concourse-latest.yml https://raw.githubusercontent.com/cloudfoundry-incubator/bosh-google-cpi-release/master/docs/concourse/concourse.yml
popd
