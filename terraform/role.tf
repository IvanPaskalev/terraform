resource "aws_iam_instance_profile" "profileEC2" {
  name = "profileEC2"
  role = aws_iam_role.roleEC2.name // napravih rolq za efs i q slojih tuk, dava gre6ka
}


resource "aws_iam_role" "roleEC2" {//---da napravq druga rolq, rolq za ec2 da se registrira pred ecs (ecs access)
  name = "roleEC2"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "sts:AssumeRole"
            ],
            "Principal": {
                "Service": [
                    "ec2.amazonaws.com"
                ]
            }
        }
    ]
    # "Statement": [
    #     {
    #         "Effect": "Allow",
    #         "Action": [
    #             "backup-storage:MountCapsule",
    #             "ec2:CreateNetworkInterface",
    #             "ec2:DeleteNetworkInterface",
    #             "ec2:DescribeSecurityGroups",
    #             "ec2:DescribeSubnets",
    #             "ec2:DescribeNetworkInterfaceAttribute",
    #             "ec2:ModifyNetworkInterfaceAttribute",
    #             "tag:GetResources"
    #         ],
    #         "Resource": "*"
    #     },
    #     {
    #         "Effect": "Allow",
    #         "Action": [
    #             "kms:DescribeKey"
    #         ],
    #         "Resource": "arn:aws:kms:*:*:key/*"
    #     },
    #     {
    #         "Effect": "Allow",
    #         "Action": [
    #             "backup:CreateBackupVault",
    #             "backup:PutBackupVaultAccessPolicy"
    #         ],
    #         "Resource": [
    #             "arn:aws:backup:*:*:backup-vault:aws/efs/automatic-backup-vault"
    #         ]
    #     },
    #     {
    #         "Effect": "Allow",
    #         "Action": [
    #             "backup:CreateBackupPlan",
    #             "backup:CreateBackupSelection"
    #         ],
    #         "Resource": [
    #             "arn:aws:backup:*:*:backup-plan:*"
    #         ]
    #     },
    #     {
    #         "Effect": "Allow",
    #         "Action": [
    #             "iam:CreateServiceLinkedRole"
    #         ],
    #         "Resource": "*",
    #         "Condition": {
    #             "StringEquals": {
    #                 "iam:AWSServiceName": [
    #                     "backup.amazonaws.com"
    #                 ]
    #             }
    #         }
    #     },
    #     {
    #         "Effect": "Allow",
    #         "Action": [
    #             "iam:PassRole"
    #         ],
    #         "Resource": [
    #             "arn:aws:iam::*:role/aws-service-role/backup.amazonaws.com/AWSServiceRoleForBackup"
    #         ],
    #         "Condition": {
    #             "StringLike": {
    #                 "iam:PassedToService": "backup.amazonaws.com"
    #             }
    #         }
    #     },
    #     {
    #         "Effect": "Allow",
    #         "Action": [
    #             "elasticfilesystem:DescribeFileSystems",
    #             "elasticfilesystem:CreateReplicationConfiguration",
    #             "elasticfilesystem:DescribeReplicationConfigurations",
    #             "elasticfilesystem:DeleteReplicationConfiguration"
    #         ],
    #         "Resource": "*"
    #     }
    # ]
})

  tags = {
    Name = "roleEC2"
  }
}


# resource "aws_iam_role" "efs-ec2" {
#   name = "efs-ec2"
#   assume_role_policy = jsonencode({
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "backup-storage:MountCapsule",
#                 "ec2:CreateNetworkInterface",
#                 "ec2:DeleteNetworkInterface",
#                 "ec2:DescribeSecurityGroups",
#                 "ec2:DescribeSubnets",
#                 "ec2:DescribeNetworkInterfaceAttribute",
#                 "ec2:ModifyNetworkInterfaceAttribute",
#                 "tag:GetResources"
#             ],
#             "Resource": "*"
#         },
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "kms:DescribeKey"
#             ],
#             "Resource": "arn:aws:kms:*:*:key/*"
#         },
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "backup:CreateBackupVault",
#                 "backup:PutBackupVaultAccessPolicy"
#             ],
#             "Resource": [
#                 "arn:aws:backup:*:*:backup-vault:aws/efs/automatic-backup-vault"
#             ]
#         },
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "backup:CreateBackupPlan",
#                 "backup:CreateBackupSelection"
#             ],
#             "Resource": [
#                 "arn:aws:backup:*:*:backup-plan:*"
#             ]
#         },
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "iam:CreateServiceLinkedRole"
#             ],
#             "Resource": "*",
#             "Condition": {
#                 "StringEquals": {
#                     "iam:AWSServiceName": [
#                         "backup.amazonaws.com"
#                     ]
#                 }
#             }
#         },
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "iam:PassRole"
#             ],
#             "Resource": [
#                 "arn:aws:iam::*:role/aws-service-role/backup.amazonaws.com/AWSServiceRoleForBackup"
#             ],
#             "Condition": {
#                 "StringLike": {
#                     "iam:PassedToService": "backup.amazonaws.com"
#                 }
#             }
#         },
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "elasticfilesystem:DescribeFileSystems",
#                 "elasticfilesystem:CreateReplicationConfiguration",
#                 "elasticfilesystem:DescribeReplicationConfigurations",
#                 "elasticfilesystem:DeleteReplicationConfiguration"
#             ],
#             "Resource": "*"
#         }
#     ]
# })
#
#
#
#   tags = {
#     Name = "efs-ec2"
#   }
# }
