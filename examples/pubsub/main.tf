provider "google" {
  project = var.project
  region  = var.region
}

module "pubsub" {
  source = "../../modules/pubsub"

  coralogix_region    = var.coralogix_region
  private_key         = var.private_key
  application_name    = var.application_name
  subsystem_name      = var.subsystem_name
  newline_pattern     = var.newline_pattern
  sampling            = var.sampling
  topic               = var.topic
  function_iam_member = var.function_iam_member
  labels = {
    environment = "production"
  }
}
