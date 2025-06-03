# Referência ao bucket S3 existente
data "aws_s3_bucket" "website" {
  bucket = var.bucket_name
}

# Configuração de website estático
resource "aws_s3_bucket_website_configuration" "website" {
  bucket = data.aws_s3_bucket.website.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "404.html"
  }
}

# Política de acesso público
resource "aws_s3_bucket_public_access_block" "website" {
  bucket = data.aws_s3_bucket.website.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Política do bucket
resource "aws_s3_bucket_policy" "website" {
  bucket = data.aws_s3_bucket.website.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${data.aws_s3_bucket.website.arn}/*"
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
          data.aws_s3_bucket.website.arn,
          "${data.aws_s3_bucket.website.arn}/*"
        ]
      }
    ]
  })
}

# Outputs
output "website_url" {
  value = "http://${var.bucket_name}.s3-website-${var.aws_region}.amazonaws.com"
}

output "s3_bucket_name" {
  value = var.bucket_name
}

output "iam_user_arn" {
  value = aws_iam_user.github_actions.arn
} 