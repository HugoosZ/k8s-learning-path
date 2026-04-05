variable "project_id" {
  description = "ID del proyecto de GCP"
  type        = string
}

variable "region" {
  default = "southamerica-west1"
}

variable "zone" {
  default = "southamerica-west1-a"
}

variable "machine_type" {
  default = "e2-standard-2"
}

variable "disk_size" {
  default = 100
}