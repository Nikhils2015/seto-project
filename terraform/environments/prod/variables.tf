variable "region" {
  type = string
}

variable "environment" {
  type = string
}

variable "db_user" {
  type = string
}

variable "db_pass" {
  type      = string
  sensitive = true
}
