#!/bin/bash
echo 'Deploying infrastructure...'

set -e

terraform fmt -recursive

terraform init

terraform validate

terraform plan

terraform apply