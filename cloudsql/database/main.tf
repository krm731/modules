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

