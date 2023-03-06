
variable "image_repository" {
  type        = string
  default     = "ricoberger/script_exporter"
  description = "script exporter image repository"
}

variable "image_tag" {
  type        = string
  default     = "v2.8.0"
  description = "script exporter image tag"
}

variable "chart_version" {
  type        = string
  default     = "0.3.0"
  description = "script exporter chart version"
}

variable "scripts" {
  description = "scripts to run in the exporter"
}

variable "scripts_list" {
  type        = list(any)
  description = "list of scripts"
}