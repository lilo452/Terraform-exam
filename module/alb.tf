resource "aws_lb" "lilos-alb" {
  name               = "alb-lilo"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg.id]
  subnets            = aws_subnet.Public-Subnet[*].id
}
