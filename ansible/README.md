# Ansible para o Projeto K3s na AWS

Este diretório contém os playbooks do Ansible necessários para configurar o cluster K3s nas máquinas virtuais provisionadas na AWS.

## Pre Requisites

Before run ansible you need to configure inventory file with the correct IP addresses of the instances created by Terraform. Get the ips and update the inventory file.

```bash
$ terraform output bastion_public_ip
$ terraform output k3s_master_public_ip
$ terraform output k3s_master_private_ip
$ terraform output k3s_worker_private_ip
```

And update the inventory file `inventory/hosts.ini` with the correct values like:

```ini
[bastion]
bastion ansible_host=$BASTION_PUBLIC_IP ansible_user=ec2-user ansible_ssh_private_key_file=k3s-keypair.pem

[k3s_cluster]
master ansible_host=$K3S_MASTER_PRIVATE_IP ansible_user=ec2-user ansible_ssh_common_args='-o ProxyCommand="ssh -W %h:%p -q ec2-user@$BASTION_PUBLIC_IP"'
worker ansible_host=$K3S_WORKER_PRIVATE_IP ansible_user=ec2-user ansible_ssh_common_args='-o ProxyCommand="ssh -W %h:%p -q ec2-user@$BASTION_PUBLIC_IP"'
```


## Arquivos

- `hosts`: Inventário do Ansible com os endereços IP das máquinas virtuais.
- `k3s.yml`: Playbook do Ansible para instalar e configurar o K3s.

## Como Executar

1. Atualize o arquivo `hosts` com os IPs reais das suas máquinas virtuais.

2. Execute o playbook:

```
$ ansible-playbook -i hosts k3s.yml
```

## Nota

Certifique-se de que você tem acesso SSH às suas instâncias EC2 na AWS, e que as chaves privadas estão configuradas corretamente no arquivo `hosts`.


# Ref

Ansible playbook original: https://github.com/k3s-io/k3s-ansible