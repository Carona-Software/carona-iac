module "vpc" {
    source = "./modules/vpc"
    cidr_block = "10.0.0.0/24"
}

module "subnet_publica" {
    source = "./modules/subnet"
    vpc_id = module.vpc.id
    cidr_block = "10.0.0.0/25"
    tags_subnet = {
        Name = "subnet_publica_iac"
    }
}

module "internet_gateway" {
    source = "./modules/internet_gateway"
    vpc_id = module.vpc.id
}

module "tabela_rota_publica" {
    source = "./modules/route_table"
    vpc_id = module.vpc.id
    tags_rt = {
        Name = "route_table_publica_iac"
    }
}

module "rota_publica" {
    source = "./modules/rota"
    route_table_id = module.tabela_rota_publica.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = module.internet_gateway.id
}

module "subnet_privada" {
    source = "./modules/subnet"
    vpc_id = module.vpc.id
    cidr_block = "10.0.0.128/25"
    tags_subnet = {
        Name = "subnet_privada_iac"
    }
}

module "associacao_publica" {
    source = "./modules/associacao_tr_subnet"
    subnet_id = module.subnet_publica.id
    route_table_id = module.tabela_rota_publica.id
    tags_association_tr_subnet = {
        Name = "subnet e route_table public"
    }
}

module "elastic_ip_ng" {
    source = "./modules/elastic_ip"
    instance = null
    tags_elastic_ip = {
        Name = "ip_nat_gateway"
    }
}

module "nat_gateway" {
    source = "./modules/nat_gateway"
    allocation_id = module.elastic_ip_ng.id
    subnet_id = module.subnet_publica.id
}

module "tabela_rota_privada" {
    source = "./modules/route_table"
    vpc_id = module.vpc.id
    tags_rt = {
        Name = "route_table_privada_iac"
    }
}

module "rota_privada" {
    source = "./modules/rota"
    route_table_id = module.tabela_rota_privada.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = module.nat_gateway.id
}

module "associacao_privada" {
    source = "./modules/associacao_tr_subnet"
    subnet_id = module.subnet_privada.id
    route_table_id = module.tabela_rota_privada.id
    tags_association_tr_subnet = {
        Name = "subnet e route_table privada"
    }
}

module "sg_publico" {
    source = "./modules/security_group"
    name = "sg_publico"
    description = "security group para ec2 publica"
    vpc_id = module.vpc.id
    ingress = [{
        from_port          = 80
        to_port            = 80
        protocol           = "tcp"
        cidr_blocks        = ["0.0.0.0/0"]
        description        = "Allow HTTP traffic"
        ipv6_cidr_blocks   = []
        prefix_list_ids    = []
        security_groups    = []
        self               = false
    },
    {
        from_port          = 22
        to_port            = 22
        protocol           = "tcp"
        cidr_blocks        = ["0.0.0.0/0"]
        description        = "Allow HTTP traffic"
        ipv6_cidr_blocks   = []
        prefix_list_ids    = []
        security_groups    = []
        self               = false
    }]

    egress = [{
        from_port          = 0
        to_port            = 0
        protocol           = "-1"  # Permitir todo o tráfego
        cidr_blocks        = ["0.0.0.0/0"]
        description        = "Allow all outbound traffic"
        ipv6_cidr_blocks   = [] 
        prefix_list_ids    = []
        security_groups    = []
        self               = false
    }]

    tags_security_group = {
        Name = "public_security_group"
    }
}

module "elastic_ip_ec2" {
    source = "./modules/elastic_ip"
    instance = module.ec2_publica.id
    tags_elastic_ip = {
        Name = "ip_ec2"
    }
}

module "ec2_publica" {
    source = "./modules/ec2"
    ami = "ami-0866a3c8686eaeeba"
    instance_type = "i3.large"  
    key_name = module.key_par.key_name
    vpc_security_group_ids = [module.sg_publico.id]
    subnet_id = module.subnet_publica.id
    tags_ec2 = {
        Name = "ec2_publica_iac"
    }
    
    user_data = null

    depends_on = [
        module.ec2_privada
    ]
}

module "key_par" {
    source = "./modules/key_par"
    key_name = "ssh"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCx9osYFaL4hhITHoXztSIlT+KPl7Htq6OuTGmNHFPs7TDCpmMOIAbEP4pXyElcN8WhvmnKIj7LfxJcJhUjjbhlB2V0Ev2jEOzdJ3uU4NKmHo2CkwL03QznfEhqqa/l4CaesrWxwN9dhn6Yuzr1WBPVZezHeP1SJsT2q3j9HS2tRaveCOtoms/qX1uI3YjaAOs7WlZ+vhqEyb5UweGK2aEJ3Y7fPZPIwTI74j4NQS6Y/TaPZcgFdKmnR+uabRyBx3+PRk+eSVASA/6FVyLzeHdIQVyQha4TSzp0lq9lF3RD3p53lRWx56aRrLBZ8MlVaU4OuipRNB3hGml7n/5Tah3D5aFLvi9C8CeAmwts+PVsQnehucMH18tEzv9SQsr9L6iNiti2w4eS4l167qZfgocYUZM5xzG2idAFWGlUO9VXGwQ7B/5tphIEBj0Y8cM/Zk/90otQ3wkP6WPbZEuLVBLtiL9F0wLD2uouLS8FSHtROwPDF0UfNeb5fhwzsLtEXwVicGhr+Fv1zo93U7eGl9phFuXp19nKhI+RkW8W60yVqNi1JsC6DLtFz5RB5UDzLU4AL/xXOS137GdRvLbDTMF0ZTQfcrhVW2skO6wTsZ7Pm0vT2TlZ9NajebUnRRj59pyTm5Rq0k76+D8CZfag2MmNF55z4U4uQL+1PDm/wTl8pQ== stefanini-dom/kqteles@STFSAON005637-L"
}

module "sg_privado" {
    source = "./modules/security_group"
    name = "sg_privado"
    description = "security group para ec2 privada"
    vpc_id = module.vpc.id
    ingress = [{
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/24"]
        description = "Allow HTTP traffic"
        ipv6_cidr_blocks = []
        prefix_list_ids = []
        security_groups = []
        self = false
    }]

    egress = [{
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks        = ["0.0.0.0/0"]
        description        = "Allow all outbound traffic"
        ipv6_cidr_blocks   = [] 
        prefix_list_ids    = []
        security_groups    = []
        self               = false
    }]

    tags_security_group = {
        Name = "private_security_group"
    }
}

module "ec2_privada" {
    source = "./modules/ec2"
    ami = "ami-0866a3c8686eaeeba"
    instance_type = "i3.large"
    key_name = module.key_par.key_name
    vpc_security_group_ids = [module.sg_privado.id]    
    subnet_id = module.subnet_privada.id
    tags_ec2 = {
        Name = "ec2_privada_iac"
    }

    user_data = templatefile("./modules/ec2/automatizacao_back.sh", {
        private_ip = module.ec2_banco.private_ip
    })

    depends_on = [
        module.ec2_banco
    ]
}

module "ec2_privada_2" {
    source = "./modules/ec2"
    ami = "ami-0866a3c8686eaeeba"
    instance_type = "i3.large"
    key_name = module.key_par.key_name
    vpc_security_group_ids = [module.sg_privado.id]    
    subnet_id = module.subnet_privada.id
    tags_ec2 = {
        Name = "ec2_privada_iac_2"
    }

    user_data = templatefile("./modules/ec2/automatizacao_back.sh", {
        private_ip = module.ec2_banco.private_ip
    })

    depends_on = [
        module.ec2_banco
    ]
}

module "sg_banco" {
    source = "./modules/security_group"
    name = "sg_banco"
    description = "security group para ec2 do banco"
    vpc_id = module.vpc.id
    ingress = [{
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = ["10.0.0.128/25"]
        description = ""
        ipv6_cidr_blocks = []
        prefix_list_ids = []
        security_groups = []
        self = false
    },
    {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["10.0.0.128/25"]
        description = ""
        ipv6_cidr_blocks = []
        prefix_list_ids = []
        security_groups = []
        self = false
    },
    {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/25"]
        description = ""
        ipv6_cidr_blocks = []
        prefix_list_ids = []
        security_groups = []
        self = false
    }]

    egress = [{
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks        = ["0.0.0.0/0"]
        description        = "Allow all outbound traffic"
        ipv6_cidr_blocks   = [] 
        prefix_list_ids    = []
        security_groups    = []
        self               = false
    }]

    tags_security_group = {
        Name = "private_security_group_banco"
    }
}

module "ec2_banco" {
    source = "./modules/ec2"
    ami = "ami-0866a3c8686eaeeba"
    instance_type = "i3.large"
    key_name = module.key_par.key_name
    vpc_security_group_ids = [module.sg_banco.id]
    subnet_id = module.subnet_privada.id
    tags_ec2 = {
        Name = "ec2_privada_banco_iac"
    }

    user_data = file("./modules/ec2/automatizacao_banco.sh")
}