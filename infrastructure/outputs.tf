output "website_url" {
  description = "URL do website"
  value       = "http://${aws_s3_bucket.website.bucket}.s3-website-${var.aws_region}.amazonaws.com"
}

output "s3_bucket_name" {
  description = "Nome do bucket S3"
  value       = aws_s3_bucket.website.bucket
}

output "iam_user_arn" {
  description = "ARN do usuário IAM para GitHub Actions"
  value       = aws_iam_user.github_actions.arn
} 