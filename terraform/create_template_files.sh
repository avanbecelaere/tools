#!/usr/bin/env bash
set -e

echo "Create base terraform templates"
touch main.tf data.tf outputs.tf

if [ ! -f providers.tf ]
then
  echo "Create providers file"
  cat > providers.tf <<- PROVIDERS
provider "aws" {
  region = var.region
  default_tags {
    tags = {
      created_by = "terraform"
    }
  }
}
PROVIDERS
fi

if [ ! -f variables.tf ]
then
  echo "Create variables file"
  cat > variables.tf <<- VARIABLES
variable "region" {
  description = "AWS primary region"
  type  = string
  default = "us-west-2"
}
VARIABLES
fi

if [ ! -f locals.tf ]
then
  echo "Create locals template file"
  cat > locals.tf <<- LOCALS
locals {
}
LOCALS
fi

if [ ! -f backend.tf ]
then
  echo "Create backend template file"
  cat > backend.tf <<- BACKEND
terraform {
  backend "remote" {
    hostname = "app.terraform.io"
  }
}
BACKEND
fi

echo "Create default terraform variable file"
mkdir -p tfvars && touch tfvars/main.tfvars

echo "Create .gitignore file"
cat > .gitignore <<- IGNORE
.DS_Store
.idea
**/.terraform/**
*.tfstate*
plan.out
.terraform.lock.hcl
secret.auto.tfvars
IGNORE