output "id" {
  value       = aws_instance.ec2.id
  sensitive   = false
}

output "private_ip" {
  value       = aws_instance.ec2.private_ip
  sensitive   = false
}