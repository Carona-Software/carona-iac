output "id" {
  value       = aws_eip.ip-nat.id
  sensitive   = false
}

output "public_ip" {
  value = aws_eip.ip-nat.public_ip
}