provider "aws" {
  region                    = "us-east-1"
}

resource "aws_instance" "web-apps" {
  ami                       = var.ami
  instance_type             = var.instance_type
  key_name                  = "sandbox"
  vpc_security_group_ids    = [aws_security_group.web-SG.id]
  subnet_id                 = aws_subnet.Ic_pub_snet_A.id
  tags                      = {
    Name                    = var.tag_name
  }
}

resource "null_resource" "app-code" {
  provisioner "remote-exec" {
    inline  =["sudo yum -y install httpd"]
    connection {
      host                  = aws_instance.web-apps.public_ip
      user                  = "ec2-user"
      type                  = "ssh"
      private_key           = "${file("/Users/mani/Downloads/sandbox.pem")}"
    }
  }
}