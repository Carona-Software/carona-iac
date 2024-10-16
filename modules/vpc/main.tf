resource "aws_vpc" "vpc_carona" {
    cidr_block = var.cidr_block
    tags = {
        Name = "vpc-carona-iac"
    }
}