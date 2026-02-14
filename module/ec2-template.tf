resource "aws_launch_template" "my_template" {
  name_prefix   = "my-server-temp"
  image_id      = "ami-0ef0fafba270833fc"
  instance_type = var.instance_type
  key_name      = "terraform-key"

  network_interfaces {
    associate_public_ip_address = var.map_public_ip
    security_groups             = [aws_security_group.sg.id]
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "lilos-template"
      Create = "Terraform"
    }
  }
}
