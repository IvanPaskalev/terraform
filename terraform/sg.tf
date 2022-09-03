resource "aws_security_group" "http_ssh" {
  name        = "http_ssh"
  description = "Allow SSH HTTP inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "SSH from myip"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["46.10.59.20/32","94.26.58.242/32"]
  }

  ingress {
    description      = "HTTP from all"
    from_port        = 32768
    to_port          = 65535
    protocol         = "tcp"
    security_groups = [aws_security_group.lb-sgroup.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_security_group" "lb-sgroup" {
  name        = "lb-sgroup"
  description = "All HTTP p:80"
  vpc_id      = aws_vpc.main.id


  ingress {
    description      = "HTTP from all"
    from_port        = 80
    to_port          = 80
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "lb-sgroup"
  }
}


resource "aws_security_group" "efs" {
  name        = "efs"
  description = "Allow NFS access"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "NFS from app-host"
    from_port        = 2049
    to_port          = 2049
    protocol         = "tcp"
    security_groups = [aws_security_group.http_ssh.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}
