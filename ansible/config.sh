#!/bin/bash

# Navegar para o diretório do Terraform e extrair IPs
cd ../terraform
BASTION_IP=$(terraform output -raw bastion_public_ip)
MASTER_IP=$(terraform output -raw k3s_master_private_ip)
WORKER_IP=$(terraform output -raw k3s_worker_private_ip)

# Navegar para o diretório do Ansible e copiar a chave SSH
cd ../ansible
cp ../terraform/k3s-keypair.pem ./inventory/k3s-keypair.pem

# Copiar a chave SSH para o bastion (ajuste conforme necessário)
scp -i ./inventory/k3s-keypair.pem ./inventory/k3s-keypair.pem ec2-user@$BASTION_IP:~/.ssh/id_rsa

# Criar o arquivo de inventário Ansible
cat <<EOF > inventory/hosts.yml
---
all:
  children:
    bastion:
      hosts:
        bastion:
          ansible_host: $BASTION_IP
          ansible_user: ec2-user
          ansible_ssh_private_key_file: "./inventory/k3s-keypair.pem"
    k3s_cluster:
      children:
        server:
          hosts:
            master:
              ansible_host: $MASTER_IP
              ansible_ssh_common_args: "-o ProxyCommand=\"ssh -W %h:%p -i inventory/k3s-keypair.pem -q ec2-user@$BASTION_IP\""
              ansible_ssh_private_key_file: "./inventory/k3s-keypair.pem"
        agent:
          hosts:
            worker:
              ansible_host: $WORKER_IP
              ansible_ssh_common_args: "-o ProxyCommand=\"ssh -W %h:%p -i inventory/k3s-keypair.pem -q ec2-user@$BASTION_IP\""
              ansible_ssh_private_key_file: "./inventory/k3s-keypair.pem"

      # Required Vars
      vars:
        ansible_port: 22
        ansible_user: ec2-user
        k3s_version: v1.26.9+k3s1
        token: "awesomeTokenValue"  # Use ansible vault if you want to keep it secret
        api_endpoint: "{{ hostvars[groups['server'][0]]['ansible_host'] | default(groups['server'][0]) }}"
        extra_server_args: ""
        extra_agent_args: ""

      # Optional vars
        # cluster_context: k3s-ansible
        # api_port: 6443
        # k3s_server_location: /var/lib/rancher/k3s
        # systemd_dir: /etc/systemd/system
        # extra_service_envs: [ 'ENV_VAR1=VALUE1', 'ENV_VAR2=VALUE2' ]
        # Manifests or Airgap should be either full paths or relative to the playbook directory.
        # List of locally available manifests to apply to the cluster, useful for PVCs or Traefik modifications.
        # extra_manifests: [ '/path/to/manifest1.yaml', '/path/to/manifest2.yaml' ]
        # airgap_dir: /tmp/k3s-airgap-images
        # user_kubectl: true, by default kubectl is symlinked and configured for use by ansible_user. Set to false to only kubectl via root user.
        # server_config_yaml:  |
          # This is now an inner yaml file. Maintain the indentation.
          # YAML here will be placed as the content of /etc/rancher/k3s/config.yaml
          # See https://docs.k3s.io/installation/configuration#configuration-file
        # registries_config_yaml:  |
          # Containerd can be configured to connect to private registries and use them to pull images as needed by the kubelet.
          # YAML here will be placed as the content of /etc/rancher/k3s/registries.yaml
          # See https://docs.k3s.io/installation/private-registry
EOF

echo "Configuração do inventário do Ansible completa."
