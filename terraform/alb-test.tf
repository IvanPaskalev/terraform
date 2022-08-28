resource "aws_lb" "apache-lb" {
  name            = "apache-lb-tf"
  internal        = false
  security_groups    = [aws_security_group.lb-sgroup.id]
  subnets            = [aws_subnet.public-sub1.id, aws_subnet.public-sub2.id]

  enable_deletion_protection = false
  tags = {
    Name = "apache-lb"
  }
}

//target group
resource "aws_lb_target_group" "default-tg" {
  name     = "default-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id      = aws_vpc.main.id
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 10
    path = "/"
    interval = 30
  }
}


resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.apache-lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.default-tg.arn
    type             = "forward"
  }
}

resource "aws_lb_listener_rule" "apache-listener-rule" {
  listener_arn = aws_lb_listener.listener.arn
  priority     = 1
  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.apache.arn
  }

  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}
// target group dor service

resource "aws_lb_target_group" "apache" {
  name     = "apache"
  port     = 80
  protocol = "HTTP"
  vpc_id      = aws_vpc.main.id
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 10
    path = "/"
    interval = 30
  }
}
