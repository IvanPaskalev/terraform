resource "aws_ecs_task_definition" "apache" {
  container_definitions    = "${data.template_file.task_definition_json.rendered}"
  family                   = "apache-task-defination"
  requires_compatibilities = ["EC2"]
  volume {
    name      = "shared"
    host_path = "/home/ec2-user/shared"
  }
}

data "template_file" "task_definition_json" {
  template = "${file("${path.module}/apache.json")}"
}
