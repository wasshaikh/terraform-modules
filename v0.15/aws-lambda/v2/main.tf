locals {
	lambda_zip = "${var.source_directory}/terraform_${var.name}.zip"
}

data "archive_file" "default" {
	excludes = concat(["terraform_${var.name}.zip"], var.excluded_files) 
	output_path = local.lambda_zip
	source_dir = var.source_directory
	type = "zip"
}

resource "aws_iam_role" "default" {
  name = "roleLambda"

  assume_role_policy = <<-POLICY
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "lambda.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  }
  POLICY
}


resource "aws_cloudwatch_event_rule" "lambda_function" {
    name = "lambda_function"
    description = "Fires every five minutes"
    schedule_expression = "cron(55 12 * * ? *)"
}

resource "aws_iam_role_policy" "cwl_policy" {
  name = "cwl_policy"
  role = aws_iam_role.default.name

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
}



resource "aws_lambda_function" "default" {
	filename = local.lambda_zip
	function_name = var.name
	handler = var.handler
	memory_size = ceil(var.memory_mb)
	role = aws_iam_role.default.name.arn
	runtime = var.runtime
	source_code_hash = data.archive_file.default.output_base64sha256
	timeout = var.timeout_after_seconds

	
}
