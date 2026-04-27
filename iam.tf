# Rol para Lambda.
resource "aws_iam_role" "lambda_exec_role" {
  name = "${var.project_name}-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

#Politica para que Lambda escriba logs (CloudWatch)
#tfsec:ignore:aws-iam-no-policy-wildcards
resource "aws_iam_policy" "lambda_logging" {
  name        = "${var.project_name}-logging-policy"
  description = "Permitir lambda escribir logs"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
      Effect = "Allow"
      # Decimos que ignore los riesgos de seguridad *
      Resource = "arn:aws:logs:*:*:*"
    }]
  })
}

# Union de Rol + Politica
resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}
