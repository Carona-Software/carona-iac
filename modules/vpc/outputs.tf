output "id" {
  value       = aws_vpc.vpc_carona.id
  sensitive   = false
  description = "Exportação do id da vpc"
}
