### VPC

Module for creation of VPC.
Creation of public and private subnet with given AZs.

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| private\_subnet | n/a | <pre>list(object({<br>        availability_zone   =   string,<br>        cidr_block          = string<br>    }))</pre> | n/a | yes |
| public\_subnet | List of CIDR\_blocks and availability zone for subnet. Each AZ may have multiple subnets | <pre>list(object({<br>        availability_zone = string,<br>        cidr_block = string<br>    }))</pre> | n/a | yes |
| vpc\_cidr\_block | VPC CIDR network | `string` | n/a | yes |
| vpc\_tags | n/a | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| private\_subnets | n/a |
| public\_sub | n/a |
| vpc\_id | VPC ID |


## Usage

```
module "vpc" {
  source         = "./modules/vpc/"
  vpc_cidr_block = var.vpc_cidr_block
  vpc_tags = merge(var.vpc_tags)
  public_subnet  = var.public_subnet
  private_subnet = var.private_subnet
}
```