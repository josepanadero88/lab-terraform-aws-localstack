resource "aws_s3_bucket" "Test_bucket" {
  #cambiamos nombre por la variable del bucket
  bucket = var.bucket_name
}

# Versioning para GitHub Actions sin parametro soft_fail
resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.Test_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Bloquear acceso público (para workflow).
resource "aws_s3_bucket_public_access_block" "public_block" {
  bucket = aws_s3_bucket.Test_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Cifrar Datos (para seguridad workflow)
resource "aws_s3_bucket_server_side_encryption_configuration" "s3_encryption" {
  bucket = aws_s3_bucket.Test_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.Test_bucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.test_lambda.arn
    events              = ["s3:ObjectCreated:*"]
  }

  depends_on = [aws_lambda_permission.allow_s3]
}
