resource "aws_security_group" "master_sg" {
  name        = local.sg_names["K3sMaster"]
  description = "Security group for K3s cluster"
  vpc_id      = var.vpc_id

  # Allow SSH from the bastion security group
  ingress {
    description     = "SSH"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "All traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  depends_on = [
    aws_security_group.bastion_sg,
  ]

  tags = merge(
    var.common_tags,
    {
      Name = "K3s_Master"
  })
}

resource "aws_security_group" "k3s_worker_sg" {
  name        = local.sg_names["K3sWorker"]
  description = "Security group for K3s worker nodes"
  vpc_id      = var.vpc_id

  # Allow SSH from the bastion security group
  ingress {
    description     = "SSH"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }

  # Allow all traffic from the master security group
  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.master_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    {
      Name = "K3s_Worker"
  })

  depends_on = [
    aws_security_group.master_sg,
  ]
}


resource "aws_security_group" "bastion_sg" {
  name        = local.sg_names["Bastion"]
  description = "Security group for bastion host"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = merge(
    var.common_tags,
    {
      Name = "Bastion"
  })
}