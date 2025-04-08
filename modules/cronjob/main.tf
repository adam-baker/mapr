resource "kubernetes_cron_job_v1" "job" {
  metadata {
    name      = var.name
    namespace = var.namespace
  }

  spec {
    schedule                      = var.schedule
    successful_jobs_history_limit = var.successful_jobs_history_limit
    failed_jobs_history_limit     = var.failed_jobs_history_limit

    job_template {
      metadata {
        name = "${var.name}-template"
      }

      spec {
        template {
          metadata {
            name = "${var.name}-pod"
          }

          spec {
            restart_policy = "OnFailure"

            container {
              name  = var.name
              image = var.image
              args  = var.args
            }
          }
        }
      }
    }
  }
}
