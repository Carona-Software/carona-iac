output "id" {
  value       = aws_nat_gateway.ng.id
  sensitive   = false
  description = "ID do nat gateway a ser exportado"
}
