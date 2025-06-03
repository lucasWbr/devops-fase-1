# DevOps na Prática - Fase 1

Este projeto demonstra a integração entre GitHub e Amazon S3 para hospedagem de um site estático.

## Configuração

### 1. Configuração do Bucket S3

1. Acesse o Console da AWS
2. Crie um novo bucket S3:
   - Nome: escolha um nome único
   - Região: selecione a região mais próxima
   - Desabilite "Block all public access"
3. Configure o bucket para hospedagem de site estático:
   - Vá para as propriedades do bucket
   - Ative "Static website hosting"
   - Configure `index.html` como documento índice
   - Configure `404.html` como página de erro
4. Adicione a seguinte política ao bucket (substitua `seu-bucket` pelo nome do seu bucket):

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::seu-bucket/*"
    }
  ]
}
```

### 2. Configuração do IAM

1. Crie um novo usuário IAM para o GitHub Actions
2. Anexe a seguinte política (substitua `seu-bucket` pelo nome do seu bucket):

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:PutObject",
        "s3:GetObject",
        "s3:ListBucket",
        "s3:DeleteObject"
      ],
      "Resource": ["arn:aws:s3:::seu-bucket", "arn:aws:s3:::seu-bucket/*"]
    },
    {
      "Effect": "Allow",
      "Action": ["cloudfront:CreateInvalidation"],
      "Resource": "*"
    }
  ]
}
```

3. Guarde as credenciais (Access Key ID e Secret Access Key)

### 3. Configuração do GitHub

1. No seu repositório, vá para Settings > Secrets and variables > Actions
2. Adicione os seguintes secrets:
   - `AWS_ACCESS_KEY_ID`: Access Key do usuário IAM
   - `AWS_SECRET_ACCESS_KEY`: Secret Key do usuário IAM
   - `AWS_REGION`: Região do seu bucket (ex: us-east-1)
   - `S3_BUCKET`: Nome do seu bucket
   - `CLOUDFRONT_DISTRIBUTION_ID`: (Opcional) ID da distribuição CloudFront, se estiver usando

## Estrutura do Projeto

```
.
├── .github/
│   └── workflows/
│       └── deploy-s3.yml
├── index.html
├── 404.html
└── README.md
```

## Como Usar

1. Clone este repositório
2. Configure os secrets no GitHub conforme instruções acima
3. Faça push para a branch main
4. O GitHub Actions irá fazer o deploy automaticamente para o S3
5. Acesse seu site através do endpoint do S3 ou domínio personalizado

## Desenvolvimento Local

Para testar localmente, você pode usar qualquer servidor web simples. Por exemplo, com Python:

```bash
python -m http.server 8000
```

Então acesse `http://localhost:8000` no seu navegador.

## Contribuição

1. Faça um Fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request
