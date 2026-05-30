# Agenda Grêmio

Projeto acadêmico para automatizar alertas por e-mail sobre jogos do Grêmio, com foco inicial em configuracão DevOps, integracão contínua e infraestrutura como código.

## Fase 1: Configuração e Automação Inicial

Esta fase organiza os primeiros artefatos do projeto:

- documentacao de planejamento em `docs\planejamento.md`;
- pipeline de CI em `.github\workflows\ci.yml`;
- infraestrutura como código com Terraform em `infra\terraform`.

## Estrutura

```text
.
|-- .github\workflows\ci.yml
|-- docs\planejamento.md
|-- infra\terraform
|   |-- lambda\handler.py
|   |-- main.tf
|   |-- outputs.tf
|   |-- variables.tf
|   `-- versions.tf
`-- README.md
```

## Validação local

```powershell
Set-Location -LiteralPath '.\infra\terraform'
terraform fmt -check -recursive
terraform init -backend=false
terraform validate
```
