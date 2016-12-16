#!/bin/bash

set -eu

self_dir=$(dirname "${BASH_SOURCE[0]}")
source $self_dir/terraform-prereq-export.sh
terra_dir_name=terraform-gcp-tmp-$GCP_CONCOURSE_PROJECT_ID

terra_dir=$self_dir/$terra_dir_name
mkdir -p $terra_dir
pushd $terra_dir
echo "Getting .tf files. NOTE: variables will be overridden e.g. -var projectid=${projectid}"
wget -nc https://raw.githubusercontent.com/cloudfoundry-incubator/bosh-google-cpi-release/master/docs/concourse/main.tf
wget -nc https://raw.githubusercontent.com/cloudfoundry-incubator/bosh-google-cpi-release/master/docs/concourse/concourse.tf

terraform plan -var projectid=${projectid} -var region=${region} -var zone-1=${zone} -var zone-2=${zone2}
read -p "Please review plan above. Continue with apply (y/n)?" choice
   if [ "$choice" != "y" ]; then
       exit 1
   fi
terraform apply -var projectid=${projectid} -var region=${region} -var zone-1=${zone} -var zone-2=${zone2}
popd

echo "Check the progess of the set up here https://console.cloud.google.com/home/activity?project=${projectid}"
echo
echo "A bastion jumpbox VM instance should now be available as seen here https://console.cloud.google.com/compute/instances?project=${projectid}"
echo
echo "You are now ready to run the jumpbox set up scripts to create a bosh director and a concourse deployment"


