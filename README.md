# gcp-concourse-init

### Prerequisites

- You must have the terraform CLI installed on your workstation. See [Download Terraform](https://www.terraform.io/downloads.html) for more details.
- You must have the gcloud CLI installed on your workstation. See https://cloud.google.com/sdk/.
- Know your preferred GCP region and zones

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

`./setup-gcloud-service-accounts.sh`

Then the infrastructure is set up via Terraform

`./create-infra-with-terraform.sh` which will prompt you to review the terraform plan before proceeding to run `terraform apply`
