# gcp-concourse-init

### Prerequisites

- You must have the terraform CLI installed on your workstation. See [Download Terraform](https://www.terraform.io/downloads.html) for more details.
- You must have the gcloud CLI installed on your workstation. See https://cloud.google.com/sdk/.
- Create a new project from the console https://console.cloud.google.com and note the porject id
- Choose your preferred GCP region and zones https://cloud.google.com/compute/docs/regions-zones/regions-zones

Scripts referenced below are meant to be run locally and they will ssh onto your gcp jumpbox to run commands remotely. This is so the jumpbox can be torn down and rebuilt easily.

### Set Up Workstation

Add the following exports to .bash_profile or equivalent

`export GCP_CONCOURSE_PROJECT_ID=<projectid_from_gcp>`

`export GCP_CONCOURSE_REGION=<preferred_gcp_region>`

`export GCP_CONCOURSE_ZONE_1=<preferred_gcp_zone_1>`

`export GCP_CONCOURSE_ZONE_2=<preferred_gcp_zone_2>`

`export GCP_CONCOURSE_COMMON_PASSWORD=<some_password>`

`export GCP_CONCOURSE_ATC_PASSWORD=<some_other_password>`

### Set Up GCP

Your GCP project needs to be configured with the required service accounts (should be a one time set up unless you destroy your project)

`./setup-gcloud-service-accounts.sh` which will open up a browser for OAuth2 permissions

You must then enable the Compute Engine API by going to the link in the output of the previous script. Wait for the enable to complete before moving on the next part.

To complete this part the infrastructure is set up via Terraform

`./create-infra-with-terraform.sh` which will prompt you to review the terraform plan before proceeding to run `terraform apply`

### Set Up a Bosh Director

NOTE: Given the limit on the free tier of 8 cpu the VMs in these scripts are being limited to 1 cpu (this is the only change from the recommended config from the Concourse GCP cpi set up docs)

For a new GCP project, ssh keys will be required to be generated. You will be prompted accordingly where

1. When given a warning that "You do not have an SSH key for Google Compute Engine", you should choose a passphrase and allow a new key to be generated. This will generate a local key/pair named google_compute_engine/google_compute_engine.pub and upload the public key to your account
2. TBC

`./jumpbox/bosh-set-up-scripts.sh`
