locals {
  build_file_name = "${var.layer-name}.zip"
  s3_artifact_key_base = "artifacts"
}

data "archive_file" "lambda-layer-local-artifact" {
  type = "zip"
  source_dir="${var.local-layer-directory}"
  output_path = "${var.local-build-directory}/${local.build_file_name}"
}

resource "aws_s3_bucket_object" "lambda-layer-s3-artifact" {
  bucket = "${var.artifact-bucket-name}"
  key = "${local.s3_artifact_key_base}/${local.build_file_name}"
  source = "${data.archive_file.lambda-layer-local-artifact.output_path}"
  etag = "${filemd5(data.archive_file.lambda-layer-local-artifact.output_path)}"
}

resource "aws_lambda_layer_version" "lambda-layer-resource" {
  layer_name = "${var.layer-name}"
  compatible_runtimes = ["python3.6"]
  s3_bucket = "${aws_s3_bucket_object.lambda-layer-s3-artifact.bucket}"
  s3_key = "${aws_s3_bucket_object.lambda-layer-s3-artifact.key}"
  source_code_hash = "${filebase64sha256(aws_s3_bucket_object.lambda-layer-s3-artifact.source)}"
}
