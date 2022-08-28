resource "aws_db_instance" "rds" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "8.0.28"
  instance_class       = "db.t3.micro"
  name                 = "mydb"
  username             = "user"
  password             = "password"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.rds.id
  vpc_security_group_ids = [aws_security_group.rds.id]
}

resource "aws_db_subnet_group" "rds" {
  name       = "rds"
  subnet_ids = [aws_subnet.private-sub1.id, aws_subnet.private-sub2.id]

  tags = {
    Name = "rds"
  }
}

resource "aws_security_group" "rds" {
  name        = "rds"
  description = "Allow SSH HTTP inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "SSH from myip"
    from_port        = 5432
    to_port          = 5432
    protocol         = "tcp"
    cidr_blocks      = ["46.10.59.20/32","94.26.58.242/32"]
  }

  ingress {
    description      = "HTTP from all"
    from_port        = 5432
    to_port          = 5432
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
    Name = "rds"
  }
}
