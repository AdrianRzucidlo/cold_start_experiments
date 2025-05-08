variable "project_id" {
  type    = string
  default = "cold-start-experiments"
}

variable "region" {
  type    = string
  default = "europe-central2"
}

variable "functions_bucket_name" {
  type    = string
  default = "cold-start-experiments-functions"
}

variable "logs_bucket_name" {
  type    = string
  default = "cold-start-experiments-functions"
}
