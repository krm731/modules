resource "google_sql_database_instance" "instance" {
	provider            = google-beta
  name                = var.instance_name
	project             = var.project.project_id
  database_version    = "POSTGRES_11"
  encryption_key_name = var.encryption_key_name

  settings {
    tier              = "db-f1-micro"
    availability_type = "REGIONAL"
    disk_size         = 10  
    ip_configuration {
      ipv4_enabled    = false
      private_network = var.network.self_link
    }
  }

// TBD
//  depends_on        = [google_service_networking_connection.private_vpc_connection]
}

// These should be multiple per database insance
resource "google_sql_database" "database" {
  name     = var.database_name
	project  = var.project.project_id
  instance = google_sql_database_instance.instance.name
}

resource "google_sql_user" "db_user" {
	project  = var.project.project_id
  instance = google_sql_database_instance.instance.name

  name     = var.user
  password = var.password
}