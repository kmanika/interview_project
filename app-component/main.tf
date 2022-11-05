provider "aws" {
  region                    = "us-east-1"
}

resource "aws_instance" "web-apps" {
  ami                       = "ami-09d3b3274b6c5d4aa"
  instance_type             = "t2.micro"
  vpc_security_group_ids    = [aws_security_group.web-SG.id]
  subnet_id                 = aws_subnet.Ic_pub_snet_A.id
  tags                      = {
    Name                    = "Web-server"
  }
}