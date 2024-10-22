resource "aws_launch_template" "web_launch_template" {
  name_prefix   = "web-server-"
  image_id      = "ami-06b21ccaeff8cd686"
  instance_type = "t2.micro"
  key_name      = var.key_name

  network_interfaces {
    associate_public_ip_address = true
    delete_on_termination       = true
    subnet_id                   = element(module.vpc.public_subnets, 0)

    security_groups = [aws_security_group.ec2-sg.id]
  }

  # User data to install and start a simple web server
  # Reference the Bash script using file()
  user_data = base64encode(file("create_webserver.sh"))

  tags = {
    Name = "WebServer"
  }
}

