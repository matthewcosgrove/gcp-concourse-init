#!/bin/bash

set -eu

self_dir=$(dirname "${BASH_SOURCE[0]}")
source $self_dir/local-exports.sh
terra_dir_name=terraform-gcp-tmp

terra_dir=$self_dir/$terra_dir_name
mkdir -p $terra_dir
pushd $terra_dir
echo "Getting .tf files"
wget -nc https://raw.githubusercontent.com/cloudfoundry-incubator/bosh-google-cpi-release/master/docs/concourse/main.tf
wget -nc https://raw.githubusercontent.com/cloudfoundry-incubator/bosh-google-cpi-release/master/docs/concourse/concourse.tf

terraform plan -var projectid=${projectid} -var region=${region} -var zone-1=${zone} -var zone-2=${zone2}
read -p "Please review plan above. Continue with apply (y/n)?" choice
   if [ "$choice" != "y" ]; then
       exit 1
   fi
terraform apply -var projectid=${projectid} -var region=${region} -var zone-1=${zone} -var zone-2=${zone2}
popd


