#!/bin/bash

set -eu
: ${GCP_CONCOURSE_ZONE_2:?"Need to set GCP_CONCOURSE_ZONE_2 non-empty"}

env_vars="GCP_CONCOURSE_ZONE_2=$GCP_CONCOURSE_ZONE_2"

self_dir=$(dirname "${BASH_SOURCE[0]}")
source $self_dir/shared-variables.sh

echo $($ssh_bastion "mkdir -p $files_dir")
printf '%s\n' "Directory $files_dir is created"

shared_variables="$self_dir/shared-variables.sh"
shared_variables_dest="~/shared-variables.sh"
printf '%s\n' "Uploading $shared_variables to $shared_variables_dest"

manifest_template="$self_dir/remote/manifest.yml.erb"
manifest_template_dest="~/$files_dir/manifest.yml.erb"
printf '%s\n' "Uploading $manifest_template to $manifest_template_dest"
echo $(cat $shared_variables | $ssh_bastion "cat > $shared_variables_dest")
$ssh_bastion "echo export $env_vars >> $shared_variables_dest"
echo $(cat $manifest_template | $ssh_bastion "cat > $manifest_template_dest")

exec_script="$self_dir/remote/bosh-set-up.sh"
printf '%s\n' "Executing script $exec_script"
cat $exec_script | $ssh_bastion

