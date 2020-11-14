### ECS

Module for creation of ECS.
You can create Clusters, services and tasks.


## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| asg\_desired\_size | n/a | `number` | n/a | yes |
| asg\_max\_size | n/a | `number` | n/a | yes |
| asg\_min\_size | n/a | `number` | n/a | yes |
| asg\_name | n/a | `string` | n/a | yes |
| container\_image | n/a | `string` | n/a | yes |
| container\_port | n/a | `number` | n/a | yes |
| container\_template\_file | n/a | `string` | n/a | yes |
| ecs\_cluster\_name | n/a | `string` | n/a | yes |
| ecs\_container\_name | n/a | `string` | n/a | yes |
| ecs\_service\_desired\_count | n/a | `number` | n/a | yes |
| ecs\_service\_name | n/a | `string` | n/a | yes |
| instance\_ami\_id | n/a | `string` | n/a | yes |
| instance\_key\_name | n/a | `string` | n/a | yes |
| instance\_public\_key | n/a | `string` | n/a | yes |
| instance\_type | n/a | `string` | n/a | yes |
| public\_subnet | n/a | `list(string)` | n/a | yes |
| vpc\_id | n/a | `string` | n/a | yes |

## Outputs

No output.

## Usage

```
module "ecs" {
  source                    = "./modules/ecs/"
  vpc_id                    = module.vpc.vpc_id
  public_subnet             = module.vpc.public_sub
  ecs_cluster_name          = var.ecs_cluster_name
  ecs_service_name          = var.ecs_service_name
  ecs_container_name        = var.ecs_container_name
  container_port            = var.container_port
  container_template_file   = var.container_template_file
  container_image           = var.container_image
  ecs_service_desired_count = var.ecs_service_desired_count
  instance_key_name         = var.instance_key_name
  instance_public_key       = var.instance_public_key
  instance_type             = var.instance_type
  instance_ami_id           = var.instance_ami_id
  asg_name                  = var.asg_name
  asg_max_size              = var.asg_max_size
  asg_min_size              = var.asg_min_size
  asg_desired_size          = var.asg_desired_size
}
```

## Extra 

This module also creates some Cloudwatch alarms for ECS components and Load Balancer