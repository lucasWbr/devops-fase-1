# DevOps na Prática - Fase 1

Este projeto demonstra a implementação de um pipeline DevOps para hospedagem de um site estático na AWS, utilizando as seguintes tecnologias e práticas:

- Amazon S3 para hospedagem
- GitHub Actions para CI/CD
- Terraform para Infraestrutura como Código (IaC)
- AWS IAM para gerenciamento de permissões

## Estrutura do Projeto

```
.
├── .github/
│   └── workflows/
│       └── deploy.yml      # Pipeline de CI/CD
├── infrastructure/
│   ├── main.tf            # Configuração principal do Terraform
│   ├── variables.tf       # Variáveis do Terraform
│   └── outputs.tf         # Outputs do Terraform
├── website/
│   ├── index.html         # Página inicial
│   └── 404.html          # Página de erro 404
└── README.md             # Este arquivo
```

## Configuração

1. **Preparação do Ambiente AWS**:

   - Configure suas credenciais AWS
   - O bucket S3 `devops-fase-1` deve existir

2. **Configuração do GitHub**:

   - Adicione os seguintes secrets no seu repositório:
     - `AWS_ACCESS_KEY_ID`: ID da chave de acesso do usuário IAM
     - `AWS_SECRET_ACCESS_KEY`: Chave secreta do usuário IAM

3. **Implantação da Infraestrutura**:

   ```bash
   cd infrastructure
   terraform init
   terraform apply
   ```

4. **Deploy Manual (se necessário)**:
   ```bash
   aws s3 sync ./website s3://devops-fase-1 --delete
   ```

## URLs Importantes

- Website: http://devops-fase-1.s3-website-us-east-1.amazonaws.com
- Repositório: [URL do seu repositório]

## Desenvolvimento

Para contribuir com o projeto:

1. Clone o repositório
2. Crie uma branch para sua feature (`git checkout -b feature/nome-da-feature`)
3. Faça commit das suas alterações (`git commit -am 'Adiciona nova feature'`)
4. Push para a branch (`git push origin feature/nome-da-feature`)
5. Crie um Pull Request

## Segurança

- O bucket S3 está configurado para acesso público apenas para leitura
- O GitHub Actions utiliza um usuário IAM dedicado com permissões mínimas necessárias
- As credenciais são armazenadas de forma segura nos secrets do GitHub

## Próximos Passos

- [ ] Adicionar CloudFront para CDN
- [ ] Implementar HTTPS
- [ ] Adicionar monitoramento e alertas
- [ ] Implementar testes automatizados
