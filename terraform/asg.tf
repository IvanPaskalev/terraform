resource "aws_launch_template" "template" {
  name_prefix   = "main"
  image_id      = data.aws_ami.image.id
  instance_type = var.instance_type
  key_name = "project"
  vpc_security_group_ids = [aws_security_group.http_ssh.id]
  iam_instance_profile {
    name = "ecs-instance-profile"
  }
  user_data = "${base64encode(<<EOF
#!/bin/bash
mkdir -p /home/ec2-user/shared
yum -y install wget
if [[ "$(python3 -V 2>&1)" =~ ^(Python 3.5.*) ]]; then
    sudo wget https://bootstrap.pypa.io/3.5/get-pip.py -O /tmp/get-pip.py
elif [[ "$(python3 -V 2>&1)" =~ ^(Python 3.4.*) ]]; then
    sudo wget https://bootstrap.pypa.io/3.4/get-pip.py -O /tmp/get-pip.py
else
    sudo wget https://bootstrap.pypa.io/get-pip.py -O /tmp/get-pip.py
fi
python3 /tmp/get-pip.py &&
pip3 install botocore &&
/usr/local/bin/pip3 install botocore &&
echo "${aws_efs_file_system.efs.id}" &&
mount -t efs -o tls "${aws_efs_file_system.efs.id}":/ /home/ec2-user/shared
echo "Hi, it works! :)" > /home/ec2-user/shared/index.html
echo "ECS_CLUSTER=apache" >> /etc/ecs/ecs.config
EOF
)}"

tag_specifications {
  resource_type = "instance"

  tags = {
    Name = var.instance_name
  }
}

  depends_on = [aws_iam_instance_profile.profileEC2]

}

resource "aws_autoscaling_group" "asg" {
  desired_capacity   = var.desired-capacity
  max_size           = var.maximum-nodes
  min_size           = var.minimum-nodes
  vpc_zone_identifier  = [aws_subnet.private-sub1.id, aws_subnet.private-sub2.id]
  # vpc_zone_identifier  = [aws_subnet.public-sub1.id, aws_subnet.public-sub2.id]
  depends_on = [aws_efs_mount_target.sub3, aws_efs_mount_target.sub4, aws_launch_template.template]

  launch_template {
    id      = aws_launch_template.template.id
    version = "$Latest"
  }
}
