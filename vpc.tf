
resource "aws_vpc" "web-app-vpc" {
  cidr_block        = "10.23.0.0/20"
  tags              = {
    Name            = "Web-app"
  }
}

resource "aws_subnet" "Ic_pub_snet_A" {
  cidr_block        = "10.23.11.0/24"
  vpc_id            = aws_vpc.web-app-vpc.id
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags              = {
    Name            = "Ic_pub_snet_A"
  }
}

resource "aws_subnet" "Ic_pvt_snet_A" {
  cidr_block        = "10.23.5.0/24"
  vpc_id            = aws_vpc.web-app-vpc.id
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
  tags              = {
    Name            = "Ic_pvt_snet_A"
  }
}

/*
resource "aws_subnet" "Ic_pvt_snet_B" {
  cidr_block        = "10.23.6.0/24"
  vpc_id            = aws_vpc.web-app-vpc.id
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = false
  tags              = {
    Name            = "Ic_pvt_snet_A"
  }
}

resource "aws_subnet" "Ic_pvt_snet_C" {
  cidr_block        = "10.23.7.0/24"
  vpc_id            = aws_vpc.web-app-vpc.id
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = false
  tags              = {
    Name            = "Ic_pvt_snet_C"
  }
}
*/

resource "aws_internet_gateway" "igw" {
  vpc_id            = aws_vpc.web-app-vpc.id
  tags              = {
    Name            = "IGW"
  }
}

resource "aws_route_table" "web-rt" {
  vpc_id             = aws_vpc.web-app-vpc.id
  route {
    cidr_block       = "0.0.0.0/0"
    gateway_id       = aws_internet_gateway.igw.id
  }
  tags               = {
    Name             = "webrt"
  }
}

resource "aws_route_table_association" "web-a" {
  route_table_id    = aws_route_table.web-rt.id
  subnet_id         = aws_subnet.Ic_pub_snet_A.id
}


resource "aws_security_group" "web-SG" {
  name = "web-app-SG"
  vpc_id = aws_vpc.web-app-vpc.id
  ingress {
    from_port = 5000
    protocol = "tcp"
    to_port = 5000
    cidr_blocks   = ["0.0.0.0/0"]
  },
  ingress {
    from_port = 80
    protocol = "http"
    to_port = 80
    cidr_blocks   = ["0.0.0.0/0"]
  },
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags            = {
    Name          = "Web-SG"
  }
}