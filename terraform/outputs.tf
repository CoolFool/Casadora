output "Availability-Domain" {
  value = data.oci_identity_availability_domains.ads.availability_domains[0].name
}

output "Instance-Image" {
  value = data.oci_core_images.ubuntu.images[0].display_name
}

output "Instance-public-IP" {
  value = oci_core_instance.casadora_instance.public_ip
}

/* output "Subnet-ID" {
  value = oci_core_subnet.casadora_public_subnet.id
}

output "Private-IPS" {
  value = data.oci_core_private_ips.casadora_private_ips.private_ips
} */

output "Adguard-DNS-Port" {
  value = var.oci_adguard_dns_port
}

output "Adguard-DNS-over-TLS-Port" {
  value = var.oci_adguard_dns_over_tls_port
}

output "Wireguard-Port" {
  value = var.oci_wireguard_port
}

output "Traefik-Hostname" {
  value = cloudflare_record.traefik.hostname
}

output "Wireguard-Hostname" {
  value = cloudflare_record.wireguard.hostname
}

output "Adguard-Hostname" {
  value = cloudflare_record.adguard.hostname
}

output "Grafana-Hostname" {
  value = cloudflare_record.grafana.hostname
}

output "Heimdall-Hostname" {
  value = cloudflare_record.heimdall.hostname
}

output "Portainer-Hostname" {
  value = cloudflare_record.portainer.hostname
}