#resource "aws_key_pair" "example_key" {
#  key_name   = var.key_name
#  public_key = file("${path.module}/example_key.pub")
#}


resource "aws_instance" "ec2_instance" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = "t2.micro"
  key_name      = var.key_name
  vpc_security_group_ids = var.security_groups
  tags = {
    Name = "ec2_instance"
  }
}

data "aws_ami" "amazon_linux_2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]

}

output "public_ip" {
  value = aws_instance.ec2_instance.public_ip
}
