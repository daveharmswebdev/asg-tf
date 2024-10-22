output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_public_subnets" {
  value = module.vpc.public_subnets
}

output "security_group_id" {
  value = aws_security_group.ec2-sg.id
}

# Output the Launch Template ID
output "launch_template_id" {
  value       = aws_launch_template.web_launch_template.id
  description = "The ID of the launch template for EC2 instances"
}

# Optional: Output the Launch Template name
output "launch_template_name" {
  value       = aws_launch_template.web_launch_template.name
  description = "The name of the launch template"
}

# Output the ALB DNS name
output "alb_dns_name" {
  value       = aws_lb.app_lb.dns_name
  description = "The DNS name of the Application Load Balancer"
}

# Output the EC2 instance IDs
output "ec2_instance_ids" {
  value       = data.aws_instances.asg_instances.ids
  description = "The IDs of the EC2 instances in the Auto Scaling Group"
}


