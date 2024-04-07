# Projeto K3s na AWS

*In development*

Este projeto provisiona um cluster K3s na AWS utilizando Terraform para o provisionamento da infraestrutura e Ansible para a configuração do cluster. O cluster é composto por uma máquina master e uma máquina worker.

## Estrutura do Projeto

O projeto está dividido em duas pastas principais:

- `terraform`: Contém os arquivos necessários para provisionar as máquinas virtuais na AWS.
- `ansible`: Contém os playbooks do Ansible para configurar o cluster K3s nas máquinas provisionadas.

## Como Usar

Siga as instruções nos `README.md` de cada subpasta (`terraform` e `ansible`) para detalhes sobre como executar e configurar cada parte do projeto.

## Observações

Os arquivos de configuração do Terraform e do Ansible estão configurados para criar um cluster K3s com uma máquina master e uma máquina worker. Você pode alterar o número de máquinas e as configurações conforme necessário.

Um container não será capaz de assumir uma role da EC2.

## Pré-Requisitos

- Terraform instalado em sua máquina local.
- Ansible instalado em sua máquina local.
- Acesso à AWS com as devidas permissões.

## Contribuições

Sinta-se à vontade para contribuir com o projeto. Toda contribuição é bem-vinda.
