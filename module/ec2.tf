# use pre-existing key pair
resource "aws_key_pair" "example" {
  key_name   = "terraform-key"
  public_key = file("C:/Users/LIHI DUCHOVNY/Desktop/terraform-labs/ssh/terraform-key.pub")

tags = {
    Name = "lilos-key-pair"
    Create = "Terraform"
  }
}

resource "aws_instance" "my_server" {
  count =var.subnet_count
  ami = "ami-0ef0fafba270833fc" 
  instance_type = var.instance_type
  subnet_id = aws_subnet.Public-Subnet[count.index].id
  associate_public_ip_address = var.map_public_ip
  vpc_security_group_ids = [aws_security_group.sg.id]
  key_name = "terraform-key"

tags = {
    Name = "lilos-instance"
    Create = "Terraform"
  }
}
  
