variable "aws_region" {
  description = "AWS region to deploy to"
  type        = string
  default     = "ap-northeast-1"
}

variable "repository_name" {
  description = "win_record_spread_sheet"
  type        = string
}

variable "vpc_cidr" {
  description = "VPCのCIDRブロック"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "パブリックサブネットのCIDRブロックリスト"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}