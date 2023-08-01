variable "coralogix_region" {
  description = "The Coralogix location region, possible options are [Europe, Europe2, India, Singapore, US]"
  type        = string
  default     = "Europe"
  validation {
    condition = contains(["Europe","Europe2","India","Singapore","US","US2"], var.coralogix_region)
    error_message = "The coralogix region must be on of these values: [Europe, Europe2, India, Singapore, US, US2]."
  }
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
}

variable "newline_pattern" {
  description = "The pattern for lines splitting"
  type        = string
  default     = "(?:\\r\\n|\\r|\\n)"
}

variable "bucket" {
  description = "The name of the GCS Bucket to watch"
  type        = string
}

variable "labels" {
  description = "A map of labels to add to Cloud Function"
  type        = map(string)
  default     = {}
}
