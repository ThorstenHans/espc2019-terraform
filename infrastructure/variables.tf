variable "environment_name" {
  type    = string
  default = "development"
}

variable "location" {
  type    = string
  default = "westeurope"
}

variable "custom_tags" {
  type    = map
  default = {}
}

variable "asp_size" {
  type    = string
  default = "S1"
}

variable "deploy_ai" {
  type    = bool
  default = true
}
