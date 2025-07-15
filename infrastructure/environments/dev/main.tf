module "vpc" {
    source              = "../../modules/vpc"
    project_name        = var.project_name
    vpc_cidr            = var.vpc_cidr
    public_subnet_cidr  = var.public_subnet_cidr
    private_subnet_cidr = var.private_subnet_cidr
    availability_zone   = var.availability_zone
    enable_nat          = var.enable_nat
}

module "security_groups" {
  source       = "../../modules/security_groups"
  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
}

module "alb" {
  source            = "../../modules/alb"
  project_name      = var.project_name
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = [module.vpc.public_subnet_id]
  alb_sg_id         = module.security_groups.alb_sg_id
}

module "secrets" {
  source                 = "../../modules/secrets"
  project_name           = var.project_name
  mongodb_connection_uri = var.mongodb_connection_uri
}

# module "ecr" {
#   source           = "../../modules/ecr"
#   repository_name  = var.project_name
# }

module "ecs" {
  source               = "../../modules/ecs"
  project_name         = var.project_name
  container_image      = "${var.ecr_repo_url}:${var.image_tag}"
  mongodb_secret_arn   = module.secrets.mongodb_secret_arn
  private_subnet_ids   = [module.vpc.private_subnet_id]
  ecs_sg_id            = module.security_groups.ecs_sg_id
  alb_target_group_arn = module.alb.target_group_arn
}
