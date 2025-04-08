variable "name" {
  type        = string
  description = "Name of the CronJob"
}

variable "namespace" {
  type        = string
  description = "Namespace to deploy into"
}

variable "schedule" {
  type        = string
  description = "Cron schedule expression"
}

variable "image" {
  type        = string
  description = "Container image to use"
}

variable "args" {
  type        = list(string)
  description = "Command-line arguments for the container"
}

variable "successful_jobs_history_limit" {
  type        = number
  description = "Number of successful job histories to retain"
  default     = 3
}

variable "failed_jobs_history_limit" {
  type        = number
  description = "Number of failed job histories to retain"
  default     = 1
}
