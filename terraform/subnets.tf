resource "aws_subnet" "public-sub1" {
  vpc_id     = aws_vpc.main.id
  availability_zone = "eu-central-1a"
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "public1"
  }
  depends_on = [aws_vpc.main]
}
resource "aws_subnet" "public-sub2" {
  vpc_id     = aws_vpc.main.id
  availability_zone = "eu-central-1b"
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "public2"
  }
  depends_on = [aws_vpc.main]
}
resource "aws_subnet" "private-sub1" {
  vpc_id     = aws_vpc.main.id
  availability_zone = "eu-central-1a"
  cidr_block = "10.0.3.0/24"
  tags = {
    Name = "private1"
  }
  depends_on = [aws_vpc.main]
}
resource "aws_subnet" "private-sub2" {
  vpc_id     = aws_vpc.main.id
  availability_zone = "eu-central-1b"
  cidr_block = "10.0.4.0/24"
  tags = {
    Name = "private2"
  }
  depends_on = [aws_vpc.main]
}
