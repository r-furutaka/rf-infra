variable "aws_region" {
  description = "AWS region to deploy to"
  type        = string
  default     = "ap-northeast-1"
}

variable "repository_name" {
  description = "win_record_spread_sheet"
  type        = string
}

variable "public_subnets" {
  description = "ECSタスクが使用するサブネットのIDリスト"
  type        = list(string)
}

variable "ecs_security_group_id" {
  description = "ECSタスクが使用するセキュリティグループのID"
  type        = string
}