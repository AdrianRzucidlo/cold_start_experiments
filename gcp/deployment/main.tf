# Common
provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_service_account" "cold-start-experiments-sa" {
  account_id   = "cold-start-experiments-sa"
  display_name = "Scheduler Service Account"
}

# Logs Processing

resource "google_cloudfunctions_function" "LogsProcessingFunction" {
  name                  = "LogsProcessingFunction"
  runtime               = "dotnet6"
  entry_point           = "LogsProcessingFunction.Function"
  region                = var.region
  source_archive_bucket = var.functions_bucket_name
  source_archive_object = "LogsProcessingFunction.zip"
  trigger_http          = true
  available_memory_mb   = 128
  service_account_email = google_service_account.cold-start-experiments-sa.email
}

resource "google_cloudfunctions_function_iam_member" "LogsProcessingFunctionIAMMember" {
  project        = var.project_id
  region         = var.region
  cloud_function = google_cloudfunctions_function.LogsProcessingFunction.name

  role   = "roles/cloudfunctions.invoker"
  member = "serviceAccount:${google_service_account.cold-start-experiments-sa.email}"
}

resource "google_cloud_scheduler_job" "LogsProcessingFunctionInvoker" {
  name      = "LogsProcessingFunctionInvoker"
  schedule  = " 5 * * * *"
  time_zone = "Europe/Warsaw"

  http_target {
    http_method = "GET"
    uri         = google_cloudfunctions_function.LogsProcessingFunction.https_trigger_url

    oidc_token {
      service_account_email = google_service_account.cold-start-experiments-sa.email
    }
  }
}

resource "google_project_iam_member" "function_logging_access" {
  project = var.project_id
  role    = "roles/logging.viewer"
  member  = "serviceAccount:${google_service_account.cold-start-experiments-sa.email}"
}

resource "google_project_iam_member" "function_storage_access" {
  project = var.project_id
  role    = "roles/storage.objectAdmin"
  member  = "serviceAccount:${google_service_account.cold-start-experiments-sa.email}"
}

# TestingFunctionPython
resource "google_cloudfunctions_function" "TestingFunctionPython" {
  name                  = "TestingFunctionPython"
  runtime               = "python311"
  entry_point           = "main"
  region                = var.region
  source_archive_bucket = var.functions_bucket_name
  source_archive_object = "TestingFunctionPython.zip"
  trigger_http          = true
  available_memory_mb   = 128
}

resource "google_cloudfunctions_function_iam_member" "TestingFunctionPythonIAMMember" {
  project        = var.project_id
  region         = var.region
  cloud_function = google_cloudfunctions_function.TestingFunctionPython.name

  role   = "roles/cloudfunctions.invoker"
  member = "serviceAccount:${google_service_account.cold-start-experiments-sa.email}"
}

resource "google_cloud_scheduler_job" "TestingFunctionPythonInvoker1" {
  name      = "TestingFunctionPythonInvoker1"
  schedule  = "0 * * * *"
  time_zone = "Europe/Warsaw"

  http_target {
    http_method = "GET"
    uri         = google_cloudfunctions_function.TestingFunctionPython.https_trigger_url

    oidc_token {
      service_account_email = google_service_account.cold-start-experiments-sa.email
    }
  }
}

resource "google_cloud_scheduler_job" "TestingFunctionPythonInvoker2" {
  name      = "TestingFunctionPythonInvoker2"
  schedule  = "1 * * * *"
  time_zone = "Europe/Warsaw"

  http_target {
    http_method = "GET"
    uri         = google_cloudfunctions_function.TestingFunctionPython.https_trigger_url

    oidc_token {
      service_account_email = google_service_account.cold-start-experiments-sa.email
    }
  }
}

# TestingFunctionDotnet

resource "google_cloudfunctions_function" "TestingFunctionDotnet" {
  name                  = "TestingFunctionDotnet"
  runtime               = "dotnet6"
  entry_point           = "TestingFunctionDotnet.Function"
  region                = var.region
  source_archive_bucket = var.functions_bucket_name
  source_archive_object = "TestingFunctionDotnet.zip"
  trigger_http          = true
  available_memory_mb   = 128
}

resource "google_cloudfunctions_function_iam_member" "TestingFunctionDotnetIAMMember" {
  project        = var.project_id
  region         = var.region
  cloud_function = google_cloudfunctions_function.TestingFunctionDotnet.name

  role   = "roles/cloudfunctions.invoker"
  member = "serviceAccount:${google_service_account.cold-start-experiments-sa.email}"
}

resource "google_cloud_scheduler_job" "TestingFunctionDotnetInvoker1" {
  name      = "TestingFunctionDotnetInvoker1"
  schedule  = "0 * * * *"
  time_zone = "Europe/Warsaw"

  http_target {
    http_method = "GET"
    uri         = google_cloudfunctions_function.TestingFunctionDotnet.https_trigger_url

    oidc_token {
      service_account_email = google_service_account.cold-start-experiments-sa.email
    }
  }
}

resource "google_cloud_scheduler_job" "TestingFunctionDotnetInvoker2" {
  name      = "TestingFunctionDotnetInvoker2"
  schedule  = "1 * * * *"
  time_zone = "Europe/Warsaw"

  http_target {
    http_method = "GET"
    uri         = google_cloudfunctions_function.TestingFunctionDotnet.https_trigger_url

    oidc_token {
      service_account_email = google_service_account.cold-start-experiments-sa.email
    }
  }
}

# Testing Function Node

resource "google_cloudfunctions_function" "TestingFunctionNode" {
  name                  = "TestingFunctionNode"
  runtime               = "nodejs18"
  entry_point           = "main"
  region                = var.region
  source_archive_bucket = var.functions_bucket_name
  source_archive_object = "TestingFunctionNode.zip"
  trigger_http          = true
  available_memory_mb   = 128
}

resource "google_cloudfunctions_function_iam_member" "TestingFunctionNodeIAMMember" {
  project        = var.project_id
  region         = var.region
  cloud_function = google_cloudfunctions_function.TestingFunctionNode.name

  role   = "roles/cloudfunctions.invoker"
  member = "serviceAccount:${google_service_account.cold-start-experiments-sa.email}"
}

resource "google_cloud_scheduler_job" "TestingFunctionNodeInvoker1" {
  name      = "TestingFunctionNodeInvoker1"
  schedule  = "0 * * * *"
  time_zone = "Europe/Warsaw"

  http_target {
    http_method = "GET"
    uri         = google_cloudfunctions_function.TestingFunctionNode.https_trigger_url

    oidc_token {
      service_account_email = google_service_account.cold-start-experiments-sa.email
    }
  }
}

resource "google_cloud_scheduler_job" "TestingFunctionNodeInvoker2" {
  name      = "TestingFunctionNodeInvoker2"
  schedule  = "1 * * * *"
  time_zone = "Europe/Warsaw"

  http_target {
    http_method = "GET"
    uri         = google_cloudfunctions_function.TestingFunctionNode.https_trigger_url

    oidc_token {
      service_account_email = google_service_account.cold-start-experiments-sa.email
    }
  }
}

# Testing Function Ruby

resource "google_cloudfunctions_function" "TestingFunctionRuby" {
  name                  = "TestingFunctionRuby"
  runtime               = "ruby32"
  entry_point           = "TestingFunctionRuby"
  region                = var.region
  source_archive_bucket = var.functions_bucket_name
  source_archive_object = "TestingFunctionRuby.zip"
  trigger_http          = true
  available_memory_mb   = 128
}

resource "google_cloudfunctions_function_iam_member" "TestingFunctionRubyIAMMember" {
  project        = var.project_id
  region         = var.region
  cloud_function = google_cloudfunctions_function.TestingFunctionRuby.name

  role   = "roles/cloudfunctions.invoker"
  member = "serviceAccount:${google_service_account.cold-start-experiments-sa.email}"
}

resource "google_cloud_scheduler_job" "TestingFunctionRubyInvoker1" {
  name      = "TestingFunctionRubyInvoker1"
  schedule  = "0 * * * *"
  time_zone = "Europe/Warsaw"

  http_target {
    http_method = "GET"
    uri         = google_cloudfunctions_function.TestingFunctionRuby.https_trigger_url

    oidc_token {
      service_account_email = google_service_account.cold-start-experiments-sa.email
    }
  }
}

resource "google_cloud_scheduler_job" "TestingFunctionRubyInvoker2" {
  name      = "TestingFunctionRubyInvoker2"
  schedule  = "1 * * * *"
  time_zone = "Europe/Warsaw"

  http_target {
    http_method = "GET"
    uri         = google_cloudfunctions_function.TestingFunctionRuby.https_trigger_url

    oidc_token {
      service_account_email = google_service_account.cold-start-experiments-sa.email
    }
  }
}

# Testing Function Java

resource "google_cloudfunctions_function" "TestingFunctionJava" {
  name                  = "TestingFunctionJava"
  runtime               = "java11"
  entry_point           = "org.example.Function"
  region                = var.region
  source_archive_bucket = var.functions_bucket_name
  source_archive_object = "TestingFunctionJava.zip"
  trigger_http          = true
  available_memory_mb   = 128
}

resource "google_cloudfunctions_function_iam_member" "TestingFunctionJavaIAMMember" {
  project        = var.project_id
  region         = var.region
  cloud_function = google_cloudfunctions_function.TestingFunctionJava.name

  role   = "roles/cloudfunctions.invoker"
  member = "serviceAccount:${google_service_account.cold-start-experiments-sa.email}"
}

resource "google_cloud_scheduler_job" "TestingFunctionJavaInvoker1" {
  name      = "TestingFunctionJavaInvoker1"
  schedule  = "0 * * * *"
  time_zone = "Europe/Warsaw"

  http_target {
    http_method = "GET"
    uri         = google_cloudfunctions_function.TestingFunctionJava.https_trigger_url

    oidc_token {
      service_account_email = google_service_account.cold-start-experiments-sa.email
    }
  }
}

resource "google_cloud_scheduler_job" "TestingFunctionJavaInvoker2" {
  name      = "TestingFunctionJavaInvoker2"
  schedule  = "1 * * * *"
  time_zone = "Europe/Warsaw"

  http_target {
    http_method = "GET"
    uri         = google_cloudfunctions_function.TestingFunctionJava.https_trigger_url

    oidc_token {
      service_account_email = google_service_account.cold-start-experiments-sa.email
    }
  }
}
