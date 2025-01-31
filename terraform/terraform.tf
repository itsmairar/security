# Configuração segura para AWS S3 com bloqueio de acesso público e criptografia
resource "aws_s3_bucket" "example" {
  bucket = "meu-bucket-seguro"
  acl    = "private"

  versioning {
    enabled = true
  }

  logging {
    target_bucket = "logs-bucket"
    target_prefix = "logs/"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket                  = aws_s3_bucket.example.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
