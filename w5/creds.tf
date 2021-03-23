resource "tls_private_key" "rsa_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "local_file" "private_key" {
    content     = tls_private_key.rsa_key.private_key_pem
    filename = "${path.module}/id_rsa"
}

resource "local_file" "public_key" {
    content     = tls_private_key.rsa_key.public_key_openssh
    filename = "${path.module}/id_rsa.pub"
}

resource "aws_key_pair" "ec2_key" {
  public_key = tls_private_key.rsa_key.public_key_openssh
}