region          = "us-east-1"
cluster_name    = "eks-dev"
namespace       = "default"

node_group_min_size = 1
node_group_max_size = 3
node_group_desired  = 2

scheduler_cronjobs = {
  "daily-cleanup" = {
    schedule = "0 2 * * *"
    image    = "myorg/cleanup-job:dev"
    args     = ["--env", "dev"]
  }

  "sync-service" = {
    schedule = "*/30 * * * *"
    image    = "myorg/sync-job:dev"
    args     = ["--mode", "sync"]
  }
}
