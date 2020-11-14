### VPC

variable "vpc_cidr_block" {
    type = string
    description = "VPC CIDR network"
}


variable "vpc_tags" {
    type = map(string)
}


### Public subnet

variable "public_subnet" {
    type = list(object({
        availability_zone = string,
        cidr_block = string
    }))
    description = "List of CIDR_blocks and availability zone for subnet. Each AZ may have multiple subnets"
}


### Private subnet

variable "private_subnet" {
    type            = list(object({
        availability_zone   =   string,
        cidr_block          = string
    }))
}

