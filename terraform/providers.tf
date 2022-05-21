terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "4.73.0"
    }
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "3.13.0"
    }
  }
}

provider "oci" {
  tenancy_ocid     = var.oci_tenancy_ocid
  user_ocid        = var.oci_user_ocid
  private_key_path = var.oci_private_key_path
  fingerprint      = var.oci_fingerprint
  region           = var.oci_region
}

provider "cloudflare" {
  api_token = var.cf_api_token
}