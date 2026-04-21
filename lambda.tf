# Convertir código a .zip
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "src/index.py"
  output_path = "lambda_function.zip"
}

#Definir la función Lambda
resource "aws_lambda_function" "test_lambda" {
  filename      = "lambda_function.zip"
  function_name = "mi-primera-lambda"
  role          = "arn:aws:iam::000000000000:role/irrelevant"
  handler       = "index.handler"
  runtime       = "python3.9"

  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
}
