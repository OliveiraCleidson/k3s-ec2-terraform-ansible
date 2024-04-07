# # Terraform para o Projeto K3s na AWS

Este diretório contém os arquivos de configuração do Terraform para provisionar a infraestrutura necessária para um cluster K3s na AWS.

Será provisionado:

- One VPC with a private and public subnet
- Three EC2 instances
  - One K3S Cluster
  - One K3S Worker
  - One Bastion

## Arquivos

- `main.tf`: Define os recursos da AWS que serão provisionados.
- `variables.tf`: Define as variáveis usadas no `main.tf`.
- `outputs.tf`: Define as saídas após o provisionamento.

## Como Executar

1. Inicialize o Terraform:

