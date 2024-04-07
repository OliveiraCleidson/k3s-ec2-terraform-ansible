resource "tls_private_key" "instances_key" {
  algorithm = "RSA"
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.ssh_key_name
  public_key = tls_private_key.instances_key.public_key_openssh
  depends_on = [
    tls_private_key.instances_key
  ]
}

resource "local_file" "private" {
  content         = tls_private_key.instances_key.private_key_pem
  filename        = "${var.ssh_key_name}.pem"
  file_permission = "0400"
  
  depends_on = [
    tls_private_key.instances_key
  ]
}

resource "local_file" "public" {
  content         = tls_private_key.instances_key.public_key_openssh
  filename        = "${var.ssh_key_name}.pub"
  file_permission = "0400"
  
  depends_on = [
    tls_private_key.instances_key
  ]
}
