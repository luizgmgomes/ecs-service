module "vpc" {
  source         = "./modules/vpc/"
  vpc_cidr_block = var.vpc_cidr_block

  vpc_tags = merge(
    var.vpc_tags
  )

  public_subnet  = var.public_subnet
  private_subnet = var.private_subnet
}


######################################################################################################################################


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
  asg_ssh_ip                = var.asg_ssh_ip
  asg_name                  = var.asg_name
  asg_max_size              = var.asg_max_size
  asg_min_size              = var.asg_min_size
  asg_desired_size          = var.asg_desired_size
}



