# Documentação de Planejamento - DevOps na Prática Fase 1

## Descrição do Projeto

Este projeto tem como objetivo implementar uma infraestrutura DevOps completa para hospedagem de um site estático, demonstrando as melhores práticas de CI/CD e Infraestrutura como Código.

### Objetivos

1. Implementar um pipeline de integração contínua robusto
2. Automatizar o provisionamento de infraestrutura usando Terraform
3. Estabelecer práticas de teste automatizado
4. Manter custos dentro do tier gratuito da AWS

### Requisitos

#### Requisitos Funcionais

- Site estático hospedado no Amazon S3
- Deploy automático via GitHub Actions
- Testes automatizados para validação de código
- Monitoramento básico de disponibilidade

#### Requisitos Não Funcionais

- Tempo de deploy inferior a 5 minutos
- Cobertura de testes mínima de 80%
- Zero custos de infraestrutura (tier gratuito)
- Documentação clara e atualizada

### Stack Tecnológica

- **Versionamento**: GitHub
- **CI/CD**: GitHub Actions
- **Infraestrutura**: AWS (S3)
- **IaC**: Terraform
- **Testes**: Jest
- **Documentação**: Markdown

### Links Importantes

- [Repositório do Projeto](https://github.com/lucasWbr/devops-fase-1)
- [Pipeline de CI/CD](https://github.com/lucasWbr/devops-fase-1/actions)

## Cronograma de Implementação

1. **Semana 1: Configuração Inicial** ✅

   - Repositório Git
   - Estrutura básica do projeto
   - Documentação inicial

2. **Semana 2: Pipeline de CI**

   - Configuração do GitHub Actions
   - Implementação de testes Jest
   - Validação de código

3. **Semana 3: Infraestrutura como Código**

   - Scripts Terraform
   - Configuração do S3
   - Políticas de IAM

4. **Semana 4: Monitoramento e Ajustes**
   - Implementação de monitoramento
   - Ajustes de performance
   - Documentação final
