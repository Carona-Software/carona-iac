resource "aws_route_table_association" "associacao-subnet-rt" {
    subnet_id = var.subnet_id
    route_table_id = var.route_table_id
}