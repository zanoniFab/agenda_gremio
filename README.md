# Agenda Grêmio

Projeto acadêmico para automatizar alertas por e-mail sobre jogos do Grêmio, com foco em DevOps, integração contínua, entrega contínua, containers, infraestrutura como código, monitoramento e segurança.

## Fase 1: Configuração e Automação Inicial

Esta fase organiza os primeiros artefatos do projeto:

- pipeline de CI em `.github\workflows\ci.yml`;
- infraestrutura como código com Terraform em `infra\terraform`.

## Fase 2: Entrega Contínua, Containers e Observabilidade

Esta fase expande o projeto com:

- pipeline de CI/CD com testes, validação Terraform, build de imagem Docker, smoke test e artefatos de entrega;
- containerização da Lambda com `Dockerfile` e `compose.yaml`;
- scripts PowerShell para build, execução local e deploy Terraform usando container;
- relatório final em `docs\relatorio-final.md`;
- fluxograma DevOps em `docs\fluxo-devops.mmd`.

## Estrutura

```text
.
|-- .github\workflows\ci.yml
|-- docs\fluxo-devops.mmd
|-- docs\relatorio-final.md
|-- scripts\build-container.ps1
|-- scripts\deploy-infra-container.ps1
|-- scripts\invoke-container.ps1
|-- scripts\run-container.ps1
|-- tests\test_handler.py
|-- compose.yaml
|-- Dockerfile
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
python -m unittest discover -s tests -p "test_*.py"

Set-Location -LiteralPath '.\infra\terraform'
terraform fmt -check -recursive
terraform init -backend=false
terraform validate
```

## Container local

```powershell
.\scripts\build-container.ps1
.\scripts\run-container.ps1
```

Em outro terminal, invoque a Lambda containerizada:

```powershell
.\scripts\invoke-container.ps1
```

Também é possível usar Docker Compose:

```powershell
docker compose up --build
```

## Deploy com Terraform em container

O script abaixo executa Terraform dentro da imagem oficial `hashicorp/terraform:1.9.8`.

```powershell
$env:AWS_ACCESS_KEY_ID = '<access-key>'
$env:AWS_SECRET_ACCESS_KEY = '<secret-key>'

.\scripts\deploy-infra-container.ps1 `
  -SenderEmail 'remetente@example.com' `
  -RecipientEmail 'destinatario@example.com' `
  -PlanOnly
```

Remova `-PlanOnly` para aplicar a infraestrutura.
