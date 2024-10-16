output "id" {
  value       = aws_internet_gateway.internet_gateway.id
  sensitive   = false
  description = "ID do internet gateway para exportação"
}