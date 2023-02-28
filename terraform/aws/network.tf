resource "aws_vpc" "network" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "network"
  }
}

resource "aws_subnet" "subnet-a" {
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-2a"
  map_public_ip_on_launch = true
  vpc_id = aws_vpc.network.id
  tags = {
    Name = "subnet-a"
  }
}

resource "aws_security_group" "ssh" {
  name_prefix = "ssh"
  vpc_id      = aws_subnet.subnet-a.vpc_id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]

  }
}

output "sg_id" {
  value = aws_security_group.ssh.id
}
