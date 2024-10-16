resource "aws_eip" "ip-nat" {
    instance = var.instance
    tags = var.tags_elastic_ip
}