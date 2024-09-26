variable "project" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
}

variable "coralogix_region" {
  description = "The Coralogix location region, possible options are [Europe, Europe2, India, Singapore, US, US2]"
  type        = string
  default     = "Europe"
}

variable "private_key" {
  description = "The Coralogix private key which is used to validate your authenticity"
  type        = string
  sensitive   = true
}

variable "application_name" {
  description = "The name of your application"
  type        = string
}

variable "subsystem_name" {
  description = "The subsystem name of your application"
  type        = string
  default     = ""
}

variable "newline_pattern" {
  description = "The pattern for lines splitting"
  type        = string
  default     = "(?:\\r\\n|\\r|\\n)"
}

variable "sampling" {
  description = "The sampling rate for the logs. default is 1"
  type        = number
  default     = 1
}

variable "topic" {
  description = "The name of the PubSub topic to watch"
  type        = string
}

variable "function_iam_member" {
  description = "The IAM member to grant the Cloud Function invoker role"
  type        = string
  default     = "allUsers"
}
