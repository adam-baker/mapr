resource "helm_release" "scheduler" {
  name       = "job-scheduler"
  chart      = "./charts/scheduler"
  namespace  = "default"

  values = [
    file("${path.module}/values/scheduler-values.yaml")
  ]

  depends_on = [module.eks]
}
