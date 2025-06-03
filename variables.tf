variable "bucket_name" {
  description = "Nome do bucket S3 para hospedagem do site"
  type        = string
  default     = "devops-fase-1"
}

variable "environment" {
  description = "Ambiente de execução (dev, prod)"
  type        = string
  default     = "prod"
}

variable "aws_region" {
  description = "Região da AWS para criar os recursos"
  type        = string
  default     = "us-east-1"
} 