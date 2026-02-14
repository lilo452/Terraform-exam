resource "aws_lb_target_group" "tg" {
  name     = "main-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.example.id

  tags = {
    Name = "lilos-tg"
    Create = "Terraform"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.lilos-alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }

  tags = {
    Name = "lilos-lb-listener"
    Create = "Terraform"
  }
}
