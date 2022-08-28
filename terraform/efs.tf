resource "aws_efs_file_system" "efs" {
  creation_token = "efs"

  tags = {
    Name = "efs"
  }
}

# resource "aws_efs_mount_target" "sub1" {
#   file_system_id = aws_efs_file_system.efs.id
#   subnet_id      = aws_subnet.public-sub1.id
#   security_groups = [aws_security_group.efs.id]
# }
#
# resource "aws_efs_mount_target" "sub2" {
#   file_system_id = aws_efs_file_system.efs.id
#   subnet_id      = aws_subnet.public-sub2.id
#   security_groups = [aws_security_group.efs.id]
# }

resource "aws_efs_mount_target" "sub3" {
  file_system_id = aws_efs_file_system.efs.id
  subnet_id      = aws_subnet.private-sub1.id
  security_groups = [aws_security_group.efs.id]
}

resource "aws_efs_mount_target" "sub4" {
  file_system_id = aws_efs_file_system.efs.id
  subnet_id      = aws_subnet.private-sub2.id
  security_groups = [aws_security_group.efs.id]
}
