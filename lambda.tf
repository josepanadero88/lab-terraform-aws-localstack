# Convertir código a .zip
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "src/index.py"
  output_path = "lambda_function.zip"
}

#Definir la función Lambda
resource "aws_lambda_function" "test_lambda" {
  filename      = "lambda_function.zip"
  function_name = "${var.project_name}-function"
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "index.handler"
  runtime       = "python3.9"

  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  # PARA PASAR EL ESCANEO DE SEGURIDAD.
  tracing_config {
    mode = "PassThrough"
  }
}
#Definir permisos Lambda
resource "aws_lambda_permission" "allow_s3" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.test_lambda.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.Test_bucket.arn
}

