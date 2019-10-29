# Required values

variable "region" {
  description   = "(Required) the region where certificate will be placed in"
  type          = "list"
}

variable "subnets" {
  description   = "(Required) subnets ALB will be placed in"
  type          = "list"
}

variable "security_groups" {
  description   = "(Required) security groups to be attached to ALB"
  type          = "list"
}

variable "domain_name" {
  description   = "(Required) ALB domain name"
  type          = "string"
}

variable "zone_id" {
  description = "(Required) Route53 Hosted zone id"
  type = "string"
}


# Optional values
variable "subject_alternative_names" {
  description = "(Optional) SANs a.k.a Subject Alternative Names"
  type        = "list"
  default     = []
}
variable "prefix" {
  description   = "(Optional) namespace default: ALB"
  default       = "ALB"
  type          = "string"
}

variable "tags" {
  description = "(Optional) Tags for resource"
  type        = "map"
  default = {
    ENV = "TEST"
  }
}


