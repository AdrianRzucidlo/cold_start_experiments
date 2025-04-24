provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_cloudfunctions_function" "scheduled_function" {
  name        = "scheduled-function"
  runtime     = "python39"
  entry_point = "main"
  region      = var.region
  source_archive_bucket = var.bucket_name
  source_archive_object = "PubSubPublisherFunction.zip"
  trigger_http = true
  available_memory_mb = 128

    environment_variables = {
    GOOGLE_FUNCTION_SOURCE = "PubSubPublisherFunction.py"
  }
}

resource "google_service_account" "scheduler_sa" {
  account_id   = "scheduler-sa"
  display_name = "Scheduler Service Account"
}

resource "google_cloudfunctions_function_iam_member" "invoker" {
  project        = var.project_id
  region         = var.region
  cloud_function = google_cloudfunctions_function.scheduled_function.name

  role   = "roles/cloudfunctions.invoker"
  member = "serviceAccount:${google_service_account.scheduler_sa.email}"
}

resource "google_cloud_scheduler_job" "call_function" {
  name        = "function-invoker"
  schedule    = "0 * * * *" # co godzinę
  time_zone   = "Europe/Warsaw"

  http_target {
    http_method = "GET"
    uri         = google_cloudfunctions_function.scheduled_function.https_trigger_url

    oidc_token {
      service_account_email = google_service_account.scheduler_sa.email
    }
  }
}
