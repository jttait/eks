# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}

variable "read_write_access_arns" {
  description = "ARNs for ECR"
  type        = list(string)
  default     = []
}
