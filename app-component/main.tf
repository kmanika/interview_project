provider "aws" {
  region                    = "us-east-1"
}

resource "aws_instance" "web-apps" {
  ami                       = var.ami
  instance_type             = var.instance_type
  vpc_security_group_ids    = [aws_security_group.web-SG.id]
  subnet_id                 = aws_subnet.Ic_pub_snet_A.id
  tags                      = {
    Name                    = var.tag_name
  }
}