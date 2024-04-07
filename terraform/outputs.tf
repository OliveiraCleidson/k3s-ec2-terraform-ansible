# K3s Mastee
output "k3s_master_public_ip" {
  value = module.ec2.k3s_master_public_ip
}

output "k3s_master_private_ip" {
  value = module.ec2.k3s_master_private_ip
}

output "k3s_master_arn" {
  value = module.ec2.k3s_master_arn
}

# K3s Worker
output "k3s_worker_private_ip" {
  value = module.ec2.k3s_worker_private_ip
}

output "k3s_worker_arn" {
  value = module.ec2.k3s_worker_arn
}

# Bastion
output "bastion_public_ip" {
  value = module.ec2.bastion_public_ip
}

output "bastion_private_ip" {
  value = module.ec2.bastion_private_ip
}

output "bastion_arn" {
  value = module.ec2.bastion_arn
}
