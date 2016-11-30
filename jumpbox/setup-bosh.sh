#!/bin/bash

set -u

bosh upload stemcell https://bosh.io/d/stemcells/bosh-google-kvm-ubuntu-trusty-go_agent?v=3263.8

bosh upload release https://bosh.io/d/github.com/concourse/concourse?v=1.5.1
bosh upload release https://bosh.io/d/github.com/cloudfoundry/garden-runc-release?v=0.4.0
