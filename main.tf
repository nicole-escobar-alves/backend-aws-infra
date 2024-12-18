terraform {
  required_version = ">=1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region     = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
  token      = var.session_token
}

module "network" {

  source = "./modules/network"

  cidr_vpc          = "10.110.0.0/16"
  cidr_subnet_int_a = "10.110.1.0/24"
  cidr_subnet_ext_a = "10.110.11.0/24"
  cidr_subnet_int_b = "10.110.2.0/24"
  cidr_subnet_ext_b = "10.110.10.0/24"
  environment       = var.environment
  region_a          = var.region-subnet-a
  region_b          = var.region-subnet-b
  route_cidr_block  = "0.0.0.0/0"
  eks_cluster_name  = var.eks_cluster_name

}

module "cluster" {

  source = "./modules/cluster"

  environment           = var.environment
  aws_region            = var.aws_region
  eks_cluster_name      = var.eks_cluster_name
  eks_version           = var.eks_version
  account_id            = var.account_id
  vpc_id                = module.network.vpc_id
  internal_subnet_1a_id = module.network.int_subnet_a_id
  internal_subnet_1b_id = module.network.int_subnet_b_id
  external_subnet_1a_id = module.network.ext_subnet_a_id
  external_subnet_1b_id = module.network.ext_subnet_b_id
}

module "nodes" {
  source = "./modules/nodes"

  environment      = var.environment
  eks_cluster_name = var.eks_cluster_name
  account_id       = var.account_id

  internal_subnet_1a_id = module.network.int_subnet_a_id
  internal_subnet_1b_id = module.network.int_subnet_b_id

  eks_cluster    = module.cluster.eks_cluster
  eks_cluster_sg = module.cluster.eks_cluster_sg

  nodes_instances_sizes = var.nodes_instances_sizes
  auto_scale_options    = var.auto_scale_options
}

module "cognito" {
  source           = "./modules/cognito"

  user_pool_name   = var.user_pool_name
  client_name      = var.client_name
  domain_name      = var.domain_name
  oauth_flows      = var.oauth_flows
  oauth_scopes     = var.oauth_scopes
  tags             = var.tags
  
  aws_region       = var.aws_region
}

module "lambda" {
  source = "./modules/lambda"
  account_id = var.account_id

  lambda_name    = var.lambda_name
  lambda_handler = var.lambda_handler
  lambda_runtime = var.lambda_runtime
  
  # apigateway_source_arn = module.api_gateway.api_source_arn
  
  # Cognito config
  cognito_client_id     = module.cognito.client_id
  cognito_client_secret = module.cognito.client_secret
  cognito_user_pool_id  = module.cognito.user_pool_id
}

module "api_gatewayv2" {
  source = "./modules/api_gatewayv2"

  lambda_arn = module.lambda.lambda_arn
  lambda_invoke_arn = module.lambda.lambda_invoke_arn

  cognito_client_id = module.cognito.client_id
  cognito_user_pool_id = module.cognito.user_pool_id
}
