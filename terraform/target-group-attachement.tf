# resource "aws_lb_target_group_attachment" "attachement" {
#   target_group_arn = aws_lb_target_group.default-tg.arn
#   target_id        = aws_lb.apache-lb.arn
#   port             = 80
#   depends_on = [aws_lb.apache-lb]
# }
#
# resource "aws_lb_target_group" "default-tg" {
#   name        = "default-tg"
#   target_type = "alb"
#   port        = 80
#   protocol    = "TCP"
#   vpc_id      = aws_vpc.main.id
#
#   health_check {
#    path     = "/"
#    protocol = "HTTP"
#   }
#
# }
