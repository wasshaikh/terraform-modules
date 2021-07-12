locals {
	lambda_zip = "${var.source_directory}/terraform_${var.name}.zip"
}

data "archive_file" "default" {
	output_path = local.lambda_zip
	source_file = var.source_file
	type = "zip"
}
data "aws_iam_policy_document" "default" {
	version = "2012-10-17"

	statement {
		actions = ["sts:AssumeRole"]
		effect = "Allow"

		principals {
			identifiers = ["lambda.amazonaws.com"]
			type = "Service"
		}
	}
}
#//5  Cloudwatch

resource "aws_cloudwatch_event_rule" "lambda_function" {
    name = "lambda_function"
    description = "Fires every five minutes"
    schedule_expression = "cron(5 * * * ? *)"
}

resource "aws_iam_role_policy" "cwl_policy" {
  name = "cwl_policy"
  role = aws_iam_role.default.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*"
    },
    {
      "Action": [
        "cloudwatch:*",
        "ec2:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF



resource "aws_iam_role" "default" {
	assume_role_policy = data.aws_iam_policy_document.default.json
}
resource "aws_iam_role_policy_attachment" "default" {
	policy_arn  = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
	role = aws_iam_role.default.name
}
resource "aws_lambda_function" "default" {
	filename = local.lambda_zip
	function_name = var.name
	handler = var.handler
	memory_size = ceil(var.memory_mb)
	role = aws_iam_role.default.arn
	runtime = var.runtime
	source_code_hash = data.archive_file.default.output_base64sha256
	timeout = var.timeout_after_seconds

	
}
