resource "aws_ecs_service" "apache" {
  name            = "apache"
  cluster         = aws_ecs_cluster.apache.id
  task_definition = aws_ecs_task_definition.apache.arn
  desired_count   = 1

  ordered_placement_strategy {
    type  = "spread"
    field = "instanceId"
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.apache.arn
    container_name   = "apache"
    container_port   = 80
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [eu-central-1a, eu-central-1b]"
  }
}
