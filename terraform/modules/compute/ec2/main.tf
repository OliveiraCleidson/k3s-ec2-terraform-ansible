resource "aws_instance" "k3s_master" {
  ami           = var.k3s_cluster_config["ami"]
  instance_type = var.k3s_cluster_config["instance_type"]
  key_name      = var.aws_instance_ssh_key

  subnet_id = var.public_subnet_id
  associate_public_ip_address = true

  iam_instance_profile = aws_iam_instance_profile.k3s_instance_profile.name
  security_groups = [aws_security_group.master_sg.id]

  tags = merge(
    var.common_tags,
    {
      Name = "K3s_Master"
    }
  )

  depends_on = [
    aws_instance.bastion,
    aws_iam_instance_profile.k3s_instance_profile,
    aws_security_group.master_sg
  ]
}

resource "aws_instance" "k3s_worker" {
  ami           = var.k3s_worker_config["ami"]
  instance_type = var.k3s_worker_config["instance_type"]
  key_name      = var.aws_instance_ssh_key

  subnet_id = var.private_subnet_id

  security_groups = [aws_security_group.k3s_worker_sg.id]
  iam_instance_profile = aws_iam_instance_profile.k3s_instance_profile.name

  tags = merge(
    var.common_tags,
    {
      Name = "K3s_Worker"
    }
  )
  
  depends_on = [
    aws_iam_instance_profile.k3s_instance_profile,
    aws_security_group.k3s_worker_sg
  ]
}

resource "aws_instance" "bastion" {
  ami           = var.bastion_config["ami"]
  instance_type = var.bastion_config["instance_type"]
  key_name      = var.aws_instance_ssh_key

  subnet_id = var.public_subnet_id
  associate_public_ip_address = true

  security_groups = [aws_security_group.bastion_sg.id]

  tags = merge(
    var.common_tags,
    {
      Name = "Bastion"
    }
  )

  depends_on = [
    aws_security_group.bastion_sg
  ]
}