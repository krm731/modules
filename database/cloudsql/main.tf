resource "google_sql_database_instance" "main" {
  name             = "main-instance"
  database_version = "MYSQL_5_6"
  depends_on       = [var.vpc_private_connection]
  settings {
    tier              = "db-f1-micro"
    availability_type = "REGIONAL"
    disk_size         = 10  
    ip_configuration {
      ipv4_enabled    = false
      private_network = var.vpc.self_link
    }
  }
}

resource "google_sql_database" "main" {
  name     = "main"
  instance = google_sql_database_instance.main.name
}

resource "google_sql_user" "db_user" {
  instance = google_sql_database_instance.main.name
  name     = var.user
  password = var.password
}