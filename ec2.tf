# Create EC2 Instance
resource "aws_instance" "my-ec2" {
  ami               = "ami-0d729d2846a86a9e7"
  instance_type     = "t2.micro"
  availability_zone = "eu-west-2a"
  key_name          = "ec2-nana"
  subnet_id              = aws_subnet.public-subnet-1.id
  vpc_security_group_ids = [aws_security_group.my-security-group.id]
  #user_data = file("apache-install.sh")
  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install httpd -y
    sudo systemctl enable httpd
    sudo systemctl start httpd
    echo "<h1>Welcome to Terraform ! AWS Infra created using Terraform in eu-west-2 Region</h1>" > /var/www/html/index.html
    EOF
  tags = {
    "Name" = "myec2vm"
  }    

} 
  
# Create EC2 Instance
resource "aws_instance" "my-ec2-2" {
  ami               = "ami-0d729d2846a86a9e7"
  instance_type     = "t2.micro"
  availability_zone = "eu-west-2b"
  key_name          = "ec2-nana"
  subnet_id              = aws_subnet.public-subnet-2.id
  vpc_security_group_ids = [aws_security_group.my-security-group.id]
  #user_data = file("apache-install.sh")
  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install httpd -y
    sudo systemctl enable httpd
    sudo systemctl start httpd
    echo "<h1>Welcome to Terraform ! AWS Infra created using Terraform in eu-west-2 Region</h1>" > /var/www/html/index.html
    EOF
  tags = {
    "Name" = "myec2vm"
  }    
} 