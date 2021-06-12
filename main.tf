data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {
  name       = var.name != "" ? "${var.github_project}-${var.name}" : var.github_project
  account_id = "${data.aws_caller_identity.current.account_id}"
  region     = "${data.aws_region.current.name}"
  ecr_repo   = "${local.account_id}.dkr.ecr.${local.region}.amazonaws.com"
  label      = var.label != "" ? var.label : "latest"
  image      = var.image != "" ? var.image : "${local.ecr_repo}/${var.github_project}:${local.label}"
  policies   = var.policies != "" ? split(",", var.policies) : []

  exec_role_arn = var.cluster_execution_role_arn
  cluster_arn   = var.cluster_arn != "" ? var.cluster_arn : var.cluster_id
  subnet        = var.subnet != "" ? var.subnet : var.cluster_private_subnets

  default_env = { environment = terraform.workspace }
  environment = merge(local.default_env, var.environment)
}

module "scheduled_task" {
  source = "github.com/aplaceformom/terraform-ecs-scheduled-task"

  name                 = local.name
  image                = local.image
  region               = local.region
  cluster_arn          = local.cluster_arn
  cpu                  = var.cpu
  memory               = var.memory
  command              = var.command
  schedule             = var.schedule
  task_role_arn        = var.task_role_arn
  exec_role_arn        = var.exec_role_arn
  cloudwatch_log_group = var.cloudwatch_log_group
  subnets              = split(",", local.subnets)
  environment          = local.environment
  secrets              = var.secrets
}
