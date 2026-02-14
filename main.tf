(* provider "aws" {
  region = "eu-west-1" 
  access_key = "AKIAUOFI5CEOSGFWQTFW"
  secret_key = "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"
} *)

module "my_infrastructure" {

  source = "C:/Users/LIHI DUCHOVNY/Desktop/terraform-labs/module"

  vpc_cidr        = "10.0.0.0/16" 
  subnet_count     = 2       
  instance_type    = "t3.micro"   
  map_public_ip = true 
  
}

output "instance_ip" {
  value = module.my_infrastructure.public_instance_ip
}

output "final_alb_url" {
  value = module.my_infrastructure.alb_dns_name
}
