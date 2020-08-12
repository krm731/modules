resource "google_folder" "folder" {
  display_name = var.name
  parent       = var.parent
}
