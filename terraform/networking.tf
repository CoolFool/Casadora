resource "oci_core_vcn" "casadora_vcn" {
  cidr_blocks    = var.oci_cidr_blocks
  dns_label      = var.oci_vcn_dns_label
  compartment_id = var.oci_tenancy_ocid
  display_name   = var.oci_vcn_display_name
}

resource "oci_core_internet_gateway" "casadora_internet_gateway" {
  compartment_id = var.oci_tenancy_ocid
  vcn_id = oci_core_vcn.casadora_vcn.id
  enabled = true
  display_name = var.oci_internet_gateway_display_name
}

resource "oci_core_route_table" "casadora_vcn_route_table" {
    compartment_id = var.oci_tenancy_ocid
    vcn_id = oci_core_vcn.casadora_vcn.id
    display_name = var.oci_route_table_display_name
    route_rules {
        network_entity_id = oci_core_internet_gateway.casadora_internet_gateway.id
        description = var.oci_route_tables_description
        destination = "0.0.0.0/0"
        destination_type = "CIDR_BLOCK"
    }
}

resource "oci_core_security_list" "casadora_security_list" {
  compartment_id = var.oci_tenancy_ocid
  vcn_id = oci_core_vcn.casadora_vcn.id
  display_name = var.oci_security_list_display_name
  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol = "all"
    description = "Allow Outbound traffic without any restrictions"
    stateless = false
  }
  ingress_security_rules {
    protocol    = 6 
    source      = "0.0.0.0/0"
    description = "TCP SSH Traffic from anywhere"
    stateless   = false
    tcp_options {
      max = var.oci_ssh_port
      min = var.oci_ssh_port
    }
  }
  ingress_security_rules {
    protocol    = 17 
    source      = "0.0.0.0/0"
    description = "UDP Wireguard traffic from anywhere"
    stateless   = false
    udp_options {
      max = var.oci_wireguard_port
      min = var.oci_wireguard_port
    }
  }
  ingress_security_rules {
    protocol    = 17 
    source      = "0.0.0.0/0"
    description = "UDP DNS traffic from anywhere"
    stateless   = false
    udp_options {
      max = var.oci_adguard_dns_port
      min = var.oci_adguard_dns_port
    }
  }
  ingress_security_rules {
    protocol    = 6 
    source      = "0.0.0.0/0"
    description = "TCP DNS traffic from anywhere"
    stateless   = false
    tcp_options {
      max = var.oci_adguard_dns_port
      min = var.oci_adguard_dns_port
    }
  }
  ingress_security_rules {
    protocol    = 6
    source      = "0.0.0.0/0"
    description = "TCP DNS-Over-TLS traffic from anywhere"
    stateless   = false
    tcp_options {
      max = var.oci_adguard_dns_over_tls_port
      min = var.oci_adguard_dns_over_tls_port
    }
  }
  ingress_security_rules {
    protocol    = 6 
    source      = "0.0.0.0/0"
    description = "TCP HTTP traffic from anywhere"
    stateless   = false
    tcp_options {
      max = 80
      min = 80
    }
  }
  ingress_security_rules {
    protocol    = 6 
    source      = "0.0.0.0/0"
    description = "TCP HTTPS traffic from anywhere"
    stateless   = false
    tcp_options {
      max = 443
      min = 443
    }
  }
}
  resource "oci_core_subnet" "casadora_public_subnet" {
    cidr_block = var.oci_subnet_cidr_block
    compartment_id = var.oci_tenancy_ocid
    vcn_id = oci_core_vcn.casadora_vcn.id
    availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
    display_name = var.oci_subnet_display_name
    route_table_id = oci_core_route_table.casadora_vcn_route_table.id
    security_list_ids = [oci_core_security_list.casadora_security_list.id]
}