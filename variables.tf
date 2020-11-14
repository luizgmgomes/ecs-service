variable "region" {
  type = string
}

variable "access_key" {
  type = string
}

variable "secret_key" {
  type = string
}


### VPC

variable "vpc_cidr_block" {
  type = string
}

variable "vpc_tags" {
  type = map(string)
}


### Public Subnet

variable "public_subnet" {
  type = list(object({
    availability_zone = string,
    cidr_block        = string
  }))
  description = "List of CIDR_blocks and availability zone for subnet. Each AZ may have multiple subnets"
}


### Private Subnet

variable "private_subnet" {
  type = list(object({
    availability_zone = string,
    cidr_block        = string
  }))
}


### ECS

variable "ecs_cluster_name" {
  type = string
}

variable "ecs_service_name" {
  type = string
}

variable "ecs_container_name" {
  type = string
}

variable "container_port" {
  type = number
}

variable "container_template_file" {
  type = string
}

variable "container_image" {
  type = string
}

variable "ecs_service_desired_count" {
  type = number
}

### ASG

variable "instance_key_name" {
  type = string
}

variable "instance_public_key" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "instance_ami_id" {
  type = string
}

variable "asg_name" {
  type = string
}

variable "asg_max_size" {
  type = number
}

variable "asg_min_size" {
  type = number
}

variable "asg_desired_size" {
  type = number
}
