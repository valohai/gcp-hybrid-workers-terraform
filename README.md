# Valohai GCP Hybrid Setup - Terraform

This repository contains a Terraform script to deploy the resources required by a Valohai Hybrid setup in GCP.

## Prerequisites

* [Install Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
* [Install gcloud](https://cloud.google.com/sdk/docs/install)
* Initialize gcloud with `gcloud init`

Make sure you've activated the following APIs in your GCP Project:
* [Compute Engine API](https://console.cloud.google.com/marketplace/product/google/compute.googleapis.com)
* [Secret Manager API](https://console.cloud.google.com/marketplace/product/google/secretmanager.googleapis.com)

## Running the Terraform template

Before running the template you'll need the following information from Valohai:
* `queue_address` that will be used for your queue
* `valohai_email` of the account Valohai will use to assume the generated service account in your GCP.

You'll need to generate default authentication credentials that Terraform can use from your workstation with `gcloud auth application-default login`. Look for the "Credentials saved to file" line to see where the file was saved. You'll need it in the next step.

You can read more about GCP authentication and Terraform [here](https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference).

Review the `variables.tfvars` file and add your project and region details.

1. Run `terraform init` to initialize a working directory with Terraform configuration files.
2. Run `terraform plan -out="valohai-init" -var-file=variables.tfvars` to create an execution plan and see what kind of changes will be applied to your GCP Project.
3. Finally execute `terraform apply "valohai-init"` to configure the resources needed for a Valohai Hybrid GCP Installation.

After you've created all the resources, you'll need to share the outputs with Valohai (`external-ip` and `project`)

## Removing Valohai resources

To remove all of the created Valohai resources empty your `valohai-data` Google Cloud Storage bucket and run `terraform destroy -var-file=variables.tfvars`.