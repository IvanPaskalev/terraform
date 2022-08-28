resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
      Name = "public"
    }
}
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public-sub1.id
  route_table_id = aws_route_table.main.id
}
resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.public-sub2.id
  route_table_id = aws_route_table.main.id
}






resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }
  tags = {
    Name = "private"
  }
  depends_on = [aws_nat_gateway.nat]
}
resource "aws_route_table_association" "private-a" {
  subnet_id      = aws_subnet.private-sub1.id
  route_table_id = aws_route_table.private.id
}
resource "aws_route_table_association" "private-b" {
  subnet_id      = aws_subnet.private-sub2.id
  route_table_id = aws_route_table.private.id
}
