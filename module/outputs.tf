output "public_instance_ip" {

  value = aws_instance.my_server[*].public_ip

}

output "alb_dns_name" {
  value = aws_lb.lilos-alb.dns_name
}
