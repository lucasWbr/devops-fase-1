output "website_url" {
  description = "URL do website"
  value       = "http://${data.aws_s3_bucket.website.id}.s3-website-${var.aws_region}.amazonaws.com"
}

output "s3_bucket_name" {
  description = "Nome do bucket S3"
  value       = data.aws_s3_bucket.website.id
} 