variable "access_key" {
  description = "Aws access key"
  type        = string
  default     = ""
}
variable "secret_key" {
  description = "Aws secret key"
  type        = string
  default     = ""
}
variable "account_id" {
  description = "Aws account id"
  type        = string
  default     = ""
}
variable "session_token" {
  description = "Aws session token"
  type        = string
  default     = ""
}
variable "aws_region" {
  description = "Região dos recursos"
  type        = string
  default     = "us-east-1"
}
variable "region-subnet-a" {
  description = "Região da subnet a"
  type        = string
  default     = "us-east-1a"
}
variable "region-subnet-b" {
  description = "Região da subnet b"
  type        = string
  default     = "us-east-1b"
}
variable "environment" {
  description = "Ambiente do recurso"
  type        = string
  default     = "Tech-Challenge"
}
variable "eks_cluster_name" {
  description = "Nome da Cluster do Elastic Kubernetes Service"
  type        = string
  default     = "Backend-Tech-Challenge"
}
variable "eks_version" {
  default = "1.30"
}
variable "nodes_instances_sizes" {
  default = [
    "t3.large"
  ]
}

variable "auto_scale_options" {
  default = {
    min     = 2
    max     = 10
    desired = 2
  }
}

############## - COGNITO - ##################
variable "user_pool_name" {
  description = "Nome do Cognito User Pool"
  type        = string
  default     = "Tech-Challenge-User-Pool2"
}

variable "client_name" {
  description = "Nome do App Client do Cognito"
  type        = string
  default     = "Tech-Challenge-App-Client3"
}

variable "domain_name" {
  description = "Prefixo do domínio para o Cognito"
  type        = string
  default     = "tech-challenge-unique3"
}

variable "oauth_flows" {
  description = "Fluxos OAuth permitidos"
  type        = list(string)
  default     = ["client_credentials"]
}

variable "oauth_scopes" {
  description = "Escopos OAuth permitidos"
  type        = list(string)
  default     = ["aws.cognito.signin.user.admin"]
}

variable "tags" {
  description = "Tags para os recursos"
  type        = map(string)
  default     = {
    "Environment" = "dev"
    "Project" = "MyProject"
  }
}

############## - API GATEWAY - ##################
variable "api_name" {
  description = "Nome da API Gateway"
  type        = string
  default     = "api_gateway_fast_food"
}

variable "api_description" {
  description = "Descrição da API Gateway"
  type        = string
  default     = "API criada com Terraform"
}

variable "path_part" {
  description = "Parte do caminho da API (ex: 'users')"
  type        = string
  default     = "admin"
}

variable "stage_name" {
  description = "Nome do estágio da API (ex: 'dev', 'prod')"
  type        = string
  default     = "dev"
}

############## - LAMBDA - ##################
variable "lambda_name" {
  description = "Nome da função Lambda"
  type        = string
  default     = "authorizer_cognito"
}

variable "lambda_handler" {
  description = "Nome do estágio da API (ex: 'dev', 'prod')"
  type        = string
  default     = "lambda_function.lambda_handler"
}

variable "lambda_runtime" {
  description = "Linguagem de execução da função Lambda"
  type        = string
  default     = "python3.12"
}