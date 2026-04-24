output "s3_bucket_name" {
  value = aws_s3_bucket.Test_bucket.id
}

output "lambda_function_name" {
  value = aws_lambda_function.test_lambda.function_name
}

output "lambda_role_arn" {
  value = aws_iam_role.lambda_exec_role.arn
}
