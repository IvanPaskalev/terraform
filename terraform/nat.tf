resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.ip.id
  subnet_id     = aws_subnet.public-sub1.id

  tags = {
    Name = "nat"
  }

  depends_on = [aws_eip.ip]
}

resource "aws_eip" "ip" {
  vpc      = true
}
