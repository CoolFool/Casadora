// Provider Start
variable "oci_tenancy_ocid" {
  type     = string
  nullable = false
}

variable "oci_user_ocid" {
  type     = string
  nullable = false
}

variable "oci_private_key_path" {
  type     = string
  nullable = false
  sensitive = true
}

variable "oci_fingerprint" {
  type     = string
  nullable = false
}

variable "oci_region" {
  type     = string
  nullable = false
}
// Providers End

// Instance Start
variable "oci_instance_shape" {
  type = string
  nullable = false
  default = "VM.Standard.A1.Flex"
}

variable "oci_instance_name" {
  type = string
  nullable = false
  default = "Casadora#1"
}

variable "oci_instance_boot_volume_size_in_gbs" {
  type = number
  default = 50
}

variable "oci_instance_memory_in_gbs" {
  type = number
  default = 6
}

variable "oci_instance_ocpus" {
  type = number
  default = 2
}

variable "oci_ssh_public_key_path" {
  type = string
  nullable = false
}

variable "oci_public_ip_lifetime" {
  type = string
  default = "EPHEMERAL"
}

variable "oci_public_ip_display_name" {
  type = string
  default = "casadora-public-ip"
}


// Instance End

// Networking Start
variable "oci_cidr_blocks" {
  type = list
  nullable = false
  default = ["10.0.0.0/16"]
}

variable "oci_vcn_dns_label" {
  type = string
  default = "casadora"
}

variable "oci_vcn_display_name" {
  type = string
  default = "Casadora VCN"
}

variable "oci_internet_gateway_display_name" {
  type = string
  default = "Casadora Internet Gateway"
}

variable "oci_route_table_display_name" {
  type = string
  default = "Casadora VCN Route Table"
}

variable "oci_route_tables_description" {
  type = string
  default = "Routing table for internet access"
}

variable "oci_security_list_display_name" {
  type = string
  default = "Casadora Security List"
}

variable "oci_ssh_port" {
  type = number
  default = 22
}

variable "oci_wireguard_port" {
  type = number
  default = 51820
}

variable "oci_adguard_dns_port" {
  type = number
  default = 53
}

variable "oci_adguard_dns_over_tls_port" {
  type = number
  default = 853
}

variable "oci_subnet_cidr_block" {
  type = string
  default = "10.0.0.0/16"
}

variable "oci_subnet_display_name" {
  type = string
  default = "Casadora Public Subnet"
}

// Networking End

//CLoudflare start

variable "cf_api_token" {
  type = string
  nullable = false
  sensitive = true
}

variable "cf_domain_name" {
  type = string
  nullable = false
}

variable "cf_traefik_record_name" {
  type = string
  nullable = false
}

variable "cf_adguard_record_name" {
  type = string
  nullable = false
}

variable "cf_heimdall_record_name" {
  type = string
  nullable = false
}

variable "cf_grafana_record_name" {
  type = string
  nullable = false
}

variable "cf_portainer_record_name" {
  type = string
  nullable = false
}

variable "cf_wireguard_record_name" {
  type = string
  nullable = false
}

//Cloudflare end

//Ansible services start
variable "ansible_ssh_private_key_path" {
  type = string
  nullable = false
}
variable "ansible_traefik_username" {
  type = string
  nullable = false
}
variable "ansible_traefik_password" {
  type = string
  nullable = false
}
variable "ansible_lets_encrypt_email" {
  type = string
  nullable = false
}
variable "ansible_adguard_username" {
  type = string
  nullable = false
}
variable "ansible_adguard_password" {
  type = string
  nullable = false
}
variable "ansible_wireguard_password" {
  type = string
  nullable = false
}

//Ansible services end