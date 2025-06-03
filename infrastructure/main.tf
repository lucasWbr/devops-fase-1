# Configuração do bucket S3
resource "aws_s3_bucket" "website" {
  bucket = var.bucket_name

  tags = {
    Environment = var.environment
    Project     = "DevOps na Prática - Fase 1"
  }
}

# Configuração de website estático
resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.website.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "404.html"
  }
}

# Política de acesso público
resource "aws_s3_bucket_public_access_block" "website" {
  bucket = aws_s3_bucket.website.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Política do bucket
resource "aws_s3_bucket_policy" "website" {
  bucket = aws_s3_bucket.website.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.website.arn}/*"
      },
    ]
  })

  depends_on = [aws_s3_bucket_public_access_block.website]
}

# Usuário IAM para GitHub Actions
resource "aws_iam_user" "github_actions" {
  name = "github-actions-${var.bucket_name}"
  path = "/service-accounts/"

  tags = {
    Environment = var.environment
    Project     = "DevOps na Prática - Fase 1"
  }
}

# Política de acesso para GitHub Actions
resource "aws_iam_user_policy" "github_actions" {
  name = "s3-sync-policy"
  user = aws_iam_user.github_actions.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket",
          "s3:DeleteObject"
        ]
        Resource = [
          aws_s3_bucket.website.arn,
          "${aws_s3_bucket.website.arn}/*"
        ]
      }
    ]
  })
} 