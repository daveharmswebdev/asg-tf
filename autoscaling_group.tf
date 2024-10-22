resource "aws_autoscaling_group" "web_asg" {
  desired_capacity = 2
  min_size         = 2
  max_size         = 2

  vpc_zone_identifier       = module.vpc.public_subnets
  health_check_type         = "ELB"
  health_check_grace_period = 300

  launch_template {
    id      = aws_launch_template.web_launch_template.id
    version = "$Latest"
  }

  # Attach to the Target Group for the ALB
  target_group_arns = [aws_lb_target_group.tg.arn]

  tag {
    key                 = "Name"
    value               = "WebServer"
    propagate_at_launch = true
  }

  termination_policies = ["OldestInstance"]
}

# Data source to fetch instances associated with the Auto Scaling Group
data "aws_autoscaling_group" "web_asg" {
  name = aws_autoscaling_group.web_asg.name
}

# Get the EC2 instance details
data "aws_instances" "asg_instances" {
  instance_tags = {
    Name = "WebServer"
  }

  filter {
    name   = "instance-state-name"
    values = ["running"]
  }
}
