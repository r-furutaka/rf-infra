variable "aws_region" {
  description = "AWS region to deploy to"
  type        = string
  default     = "ap-northeast-1"
}

variable "vpc_cidr" {
  description = "VPCのCIDRブロック"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "パブリックサブネットのCIDRブロックリスト"
  type        = list(string)
}
