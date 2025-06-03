# Especificação de Infraestrutura

## Visão Geral da Infraestrutura

A infraestrutura do projeto é totalmente hospedada na AWS, utilizando serviços dentro do tier gratuito. O provisionamento é automatizado usando Terraform.

## Componentes

### Amazon S3

- **Propósito**: Hospedagem do site estático
- **Configuração**:
  - Bucket público para acesso web
  - Configurado como website estático
  - Política de acesso público controlada
  - Versionamento desabilitado (economia de custos)

### IAM

- **Usuário de Serviço**: Para GitHub Actions
- **Políticas**: Acesso mínimo necessário ao S3
- **Rotação de Credenciais**: Manual (a cada 90 dias)

## Terraform

### Estrutura de Arquivos

```
infrastructure/
├── main.tf
├── variables.tf
├── outputs.tf
├── providers.tf
└── terraform.tfvars.example
```

### Recursos Provisionados

```hcl
# Exemplo de configuração do bucket S3
resource "aws_s3_bucket" "website" {
  bucket = "devops-fase-1"
}

resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.website.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "404.html"
  }
}

# Política de acesso ao bucket
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
}

# Usuário IAM para GitHub Actions
resource "aws_iam_user" "github_actions" {
  name = "github-actions-devops-fase-1"
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
```

## Monitoramento

### Métricas Coletadas

- Requisições por segundo
- Latência de resposta
- Erros 4xx e 5xx
- Custos (para controle do tier gratuito)

### Alertas

- Falhas de deploy
- Erros de acesso ao bucket
- Aproximação do limite do tier gratuito

## Custos Estimados

Todos os serviços estão configurados dentro do tier gratuito da AWS:

- S3: 5GB de armazenamento
- Transferência: 100GB/mês
- Requisições: 20.000/mês

## Segurança

### Práticas Implementadas

- Princípio do menor privilégio para IAM
- Bucket configurado com políticas mínimas necessárias
- Logs de acesso habilitados
- CORS configurado adequadamente

### Backups

- Arquivos versionados no GitHub
- Deploy automatizado permite recuperação rápida
