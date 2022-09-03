# resource "aws_iam_service_linked_role" "os" {
#   aws_service_name = "es.amazonaws.com"
# }
#
# resource "aws_security_group" "os-sg" {
#   name        = "os-sg"
#   description = "opensearch"
#   vpc_id      = aws_vpc.main.id
#
#
#   ingress {
#     description      = "opensearchingress"
#     from_port        = 9200
#     to_port          = 9200
#     protocol         = "TCP"
#     cidr_blocks      = ["0.0.0.0/0"]
#   }
#
#   ingress {
#     description      = "opensearchingress"
#     from_port        = 443
#     to_port          = 443
#     protocol         = "TCP"
#     cidr_blocks      = ["0.0.0.0/0"]
#   }
#
#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#   }
#
#   tags = {
#     Name = "os-sg"
#   }
# }
#
#
# resource "aws_elasticsearch_domain" "os" {
#   domain_name           = "opensearch"
#   elasticsearch_version = "OpenSearch_1.2"
#
#   cluster_config {
#     instance_type          = "r6g.large.elasticsearch"
#     zone_awareness_enabled = true
#     instance_count = 2
#   }
#
#   ebs_options {
#     ebs_enabled = true
#     volume_size = 10
#   }
#
#   vpc_options {
#     subnet_ids = [aws_subnet.private-sub1.id, aws_subnet.private-sub2.id]
#
#     security_group_ids = [aws_security_group.os-sg.id]
#   }
#
#   advanced_options = {
#     "rest.action.multi.allow_explicit_index" = "true"
#   }
#
#   access_policies = <<CONFIG
# {
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Action": "es:*",
#             "Principal": "*",
#             "Effect": "Allow",
#             "Resource": "arn:aws:es:eu-central-1:833366142445:domain/os/*"
#         }
#     ]
# }
# CONFIG
#
#   tags = {
#     Domain = "TestDomain"
#   }
#
#   depends_on = [aws_iam_service_linked_role.os]
# }
