output "lambda-layer-arn" {
  value = "${aws_lambda_layer_version.lambda-layer-resource.arn}"
}
