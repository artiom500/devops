data "aws_ami" "srv" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "default" {
  ami           = data.aws_ami.srv.id
  instance_type = "t2.micro"
  key_name      = "mykeypair"
  subnet_id     = aws_subnet.subnet-a.id
  security_groups = [aws_security_group.ssh.id]
  tags = {
    Name = "srv"
  }
}
