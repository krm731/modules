/**
 * Copyright 2019 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#-----------------#
# Local variables #
#-----------------#

locals {
  dataset_name = element(
    concat(google_bigquery_dataset.dataset.*.dataset_id, [""]),
    0,
  )
  destination_uri = "bigquery.googleapis.com/projects/${var.project_id}/datasets/${local.dataset_name}"
}

#----------------#
# API activation #
#----------------#
/*
resource "google_project_service" "enable_destination_api" {
  project            = var.project_id
  service            = "bigquery.googleapis.com"
  disable_on_destroy = false
}
*/

#------------------#
# Bigquery dataset #
#------------------#
resource "google_bigquery_dataset" "dataset" {
  dataset_id                  = var.dataset_name
  project                     = var.project_id
  location                    = var.location
  description                 = var.description
  delete_contents_on_destroy  = var.delete_contents_on_destroy
  default_table_expiration_ms = var.default_table_expiration_ms
  labels                      = var.labels
  default_encryption_configuration {
    kms_key_name = module.key.id
  }
}

module key {
  source = "github.com/ps-gcp-foundation/modules/kms/key"
  name     = var.dataset_name
  project  = var.project_id
  key_ring = google_kms_key_ring.key_ring.id
}

module key_ring {
  source = "github.com/ps-gcp-foundation/modules/kms/keyring"
  name     = var.dataset_name
  project  = var.project_id
  location = "europe"
}

data "google_iam_policy" "role" {
  binding {
    role = "roles/cloudkms.cryptoKeyEncrypterDecrypter"

    members = [
      "serviceAccount:bq-${var.project_number}@bigquery-encryption.iam.gserviceaccount.com",
    ]
  }
}

resource "google_kms_key_ring_iam_policy" "key_ring_policy" {
  key_ring_id = google_kms_key_ring.key_ring.id
  policy_data = data.google_iam_policy.role.policy_data
}

#--------------------------------#
# Service account IAM membership #
#--------------------------------#
resource "google_project_iam_member" "bigquery_sink_member" {
  project = google_bigquery_dataset.dataset.project
  role    = "roles/bigquery.dataEditor"
  member  = var.log_sink_writer_identity
}
