###############################################################################
# Script Name	:	main.tf                                                       #
# Description	:	Script to define project resources                            #
# Author		  :	Arun Kumar Lakshmi Narayanan										              #
# Powered By	Publicis Sapient Consulting									                    #
###############################################################################

# Create spinnaker namespace
resource "kubernetes_namespace" "spinnaker" {
  metadata {
    name = var.namespace
  }
}

# Create kubernetes service account for spinnaker
resource "kubernetes_service_account" "spinnaker" {
  metadata {
    name      = var.spinnaker_k8s_sa
    namespace = kubernetes_namespace.spinnaker.metadata.0.name
  }
}

#Cluster role binding
resource "kubernetes_cluster_role_binding" "example" {
  depends_on = [kubernetes_service_account.spinnaker]
  metadata {
    name = var.namespace
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    kind      = "ServiceAccount"
    name      = var.spinnaker_k8s_sa
    namespace = var.namespace
  }
}

data "template_file" "deploy_spinnaker" {
  depends_on = [kubernetes_cluster_role_binding.example]

  template = <<EOF
  set -ex \
  && GCS_KEY_FILE=~/.hal/.$${bucket}.key \
  && echo '$${gcs_json_key}' | base64 --decode > $GCS_KEY_FILE \
	&& hal -q config --set-current-deployment $${project} \
  && hal -q config provider kubernetes enable \
  && hal -q config provider kubernetes account delete spinnaker-account || true \
  && hal -q config provider kubernetes account add spinnaker-account --provider-version v2 --context $(kubectl config current-context) \
  && hal -q config version edit --version 1.19.12 \
  && hal -q config features edit --artifacts true \
  && hal -q config deploy edit --type distributed --account-name spinnaker-account \
  && hal -q config storage gcs edit --project $${project} --bucket-location $${gcs_location} --json-path $GCS_KEY_FILE --bucket $${bucket} \
  && hal -q config storage edit --type gcs \
  && hal -q deploy apply
  EOF

  vars = {
    project           = var.project.project_id
    gcs_location      = var.storage_bucket.location
    bucket            = var.storage_bucket.name
    gcs_json_key      = var.service_account_key.private_key
    spinnaker_version = var.spinnaker_version
  }
}

# Configure kubectl to use spinnaker service account
resource "null_resource" "deploy_spinnaker" {
  depends_on = [kubernetes_cluster_role_binding.example]

  provisioner "local-exec" {
    command = data.template_file.deploy_spinnaker.rendered
  }
}