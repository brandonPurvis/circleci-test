terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "bcpmax-personal"
    "workspaces" {
      name = "circleci-test"
    }
  }
}

provider "aws" {
  version = "~> 2.0"
  region = "us-east-1"
}


data "aws_s3_bucket_object" "layer-zip-file" {
  bucket = "bcpmax-apartment-artifacts"
  key    = "artifacts/selenium-layer.zip"
}


resource "aws_lambda_layer_version" "lambda-layer-resource" {
  layer_name = "selenium-layer-37"
  compatible_runtimes = ["python3.7"]
  s3_bucket = "${data.aws_s3_bucket_object.layer-zip-file.bucket}"
  s3_key = "${data.aws_s3_bucket_object.layer-zip-file.key}"
  source_code_hash = "${filebase64sha256(data.aws_s3_bucket_object.layer-zip-file.body)}"
}
