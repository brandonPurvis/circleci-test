terraform {
  backend "remote" {
    organization = "bcpmax-personal"
    "workspaces" {
      name = "APARTMENT_DATA_COLLECTION"
    }
  }
}

provider "aws" {
  version = "~> 2.0"
  region = "us-east-1"
}

# LOCALS

locals {
  local-build-dir = "${path.module}/../build"
  local-step-function-directory = "${path.module}/../step_functions"
  local-lambda-directory = "${path.module}/../lambdas"
}

# LAMBDA LAYERS

module "apartments-requirements-layer" {
  source = "./stored_aws_lambda_layer"
  artifact-bucket-name = "${aws_s3_bucket.artifacts-bucket.bucket}"
  local-layer-directory = "${path.module}/../selenium_layer"
  local-build-directory = local.local-build-dir
  layer-name = "apartments-requirements-layer"
}
