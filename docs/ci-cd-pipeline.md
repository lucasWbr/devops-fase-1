# Pipeline de Integração Contínua

## Visão Geral

O pipeline de CI/CD foi implementado usando GitHub Actions, com foco em automação de testes, validação de código e deploy contínuo para AWS S3.

## Etapas do Pipeline

### 1. Validação

- Checkout do código
- Instalação de dependências
- Execução de testes Jest
- Validação de sintaxe e estilo
- Verificação de segurança

### 2. Build

- Validação de arquivos HTML
- Minificação de assets (se necessário)
- Preparação para deploy

### 3. Deploy

- Autenticação na AWS
- Sincronização com S3
- Validação pós-deploy

## Configuração do GitHub Actions

```yaml
name: CI/CD Pipeline

on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main
  workflow_dispatch:

jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: "18"

      - name: Install dependencies
        run: npm install

      - name: Run tests
        run: npm test

      - name: Validate HTML
        run: npx html-validate ./*.html

  deploy:
    needs: validate
    if: github.ref == 'refs/heads/main'
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v1
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: us-east-1

      - name: Deploy to S3
        run: |
          aws s3 sync . s3://devops-fase-1 \
            --delete \
            --exclude ".git/*" \
            --exclude ".github/*" \
            --exclude "README.md" \
            --exclude ".gitignore"
```

## Monitoramento

- Status do pipeline disponível em GitHub Actions
- Notificações configuradas para falhas
- Métricas de tempo de execução

## Próximos Passos

1. Implementar testes de integração
2. Adicionar análise de qualidade de código
3. Configurar cache de dependências
4. Implementar deploy em ambiente de staging
