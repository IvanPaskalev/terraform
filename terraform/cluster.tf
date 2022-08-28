resource "aws_ecs_cluster" "apache" {
  name = "apache"
  # key_name = "trf"
  # subnet_id = [aws_subnet.public-sub1.id, aws_subnet.public-sub2.id]
  # vpc_id = aws_vpc.main.id
#   user_data                   = <<EOF
# #!/bin/bash -xe
# yum install httpd
# systemctl start httpd
# systemctl enable httpd.service
# firewall-cmd --add-service=http --permanent
# firewall-cmd --reload
# EOF
}
