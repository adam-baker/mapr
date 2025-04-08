provider "kubernetes" {
  config_path = "~/.kube/config"
}

module "cronjob_hello" {
  source     = "../../modules/cronjob"
  name       = "hello-cron"
  namespace  = "default"
  schedule   = "*/5 * * * *"
  image      = "busybox"
  args       = ["echo", "Hello from dev!"]
}
