resource "google_redis_instance" "cache" {
  name               = var.name
  location_id        = "europe-west2-c"
  authorized_network = var.network.id
  redis_configs      = var.redis_configs
  memory_size_gb     = 1
}