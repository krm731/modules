resource "google_compute_global_address" "private_ip_address" {
  provider = google-beta

  name          = "private-ip-address"
  project       = var.project.project_id
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = var.network.id
}

resource "google_service_networking_connection" "private_vpc_connection" {
  provider = google-beta

  network                 = var.network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

resource "google_sql_database_instance" "instance" {
  provider            = google-beta
  name                = var.instance_name
  project             = var.project.project_id
  region              = var.region
  database_version    = "POSTGRES_11"
  encryption_key_name = var.encryption_key_name

  settings {
    tier              = "db-f1-micro"
    availability_type = "REGIONAL"
    disk_size         = 10
    ip_configuration {
      ipv4_enabled    = false
      private_network = var.network.id
    }
    user_labels = { "dataclassification" = "${var.classification}",
                    "owner" = "${var.owner}"
                  }
    
  }

  depends_on = ["google_service_networking_connection.private_vpc_connection"]
}

resource "google_sql_ssl_cert" "client_cert" {
  common_name = "cloudsql-cert"
  instance    = google_sql_database_instance.instance.name
  project     = var.project.project_id
}
