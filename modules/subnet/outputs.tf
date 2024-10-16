output "id" {
  value       = aws_subnet.subnet.id
  sensitive   = false
  description = "ID da subnet a ser exportada"
}
