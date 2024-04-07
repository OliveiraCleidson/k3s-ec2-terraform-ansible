# K3s Mastee
output "k3s_master_public_ip" {
  value = aws_instance.k3s_master.public_ip
}

output "k3s_master_private_ip" {
  value = aws_instance.k3s_master.private_ip
}

output "k3s_master_arn" {
  value = aws_instance.k3s_master.arn
}

# K3s Worker
output "k3s_worker_private_ip" {
  value = aws_instance.k3s_worker.private_ip
}

output "k3s_worker_arn" {
  value = aws_instance.k3s_worker.arn
}

# Bastion
output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}

output "bastion_private_ip" {
  value = aws_instance.bastion.private_ip
}

output "bastion_arn" {
  value = aws_instance.bastion.arn
}
