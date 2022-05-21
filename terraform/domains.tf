data "cloudflare_zones" "domain" {
    filter {
        name        = var.cf_domain_name
        lookup_type = "exact"
    }
}

resource "cloudflare_record" "heimdall" {
  zone_id = data.cloudflare_zones.domain.zones[0].id
  name = var.cf_heimdall_record_name
  value = oci_core_instance.casadora_instance.public_ip
  type = "A"
  ttl = "1"
  proxied = false
}

resource "cloudflare_record" "traefik" {
  zone_id = data.cloudflare_zones.domain.zones[0].id
  name = var.cf_traefik_record_name
  value = oci_core_instance.casadora_instance.public_ip
  type = "A"
  ttl = "1"
  proxied = false
}

resource "cloudflare_record" "adguard" {
  zone_id = data.cloudflare_zones.domain.zones[0].id
  name = var.cf_adguard_record_name
  value = oci_core_instance.casadora_instance.public_ip
  type = "A"
  ttl = "1"
  proxied = false
}


resource "cloudflare_record" "grafana" {
  zone_id = data.cloudflare_zones.domain.zones[0].id
  name = var.cf_grafana_record_name
  value = oci_core_instance.casadora_instance.public_ip
  type = "A"
  ttl = "1"
  proxied = false
}

resource "cloudflare_record" "wireguard" {
  zone_id = data.cloudflare_zones.domain.zones[0].id
  name = var.cf_wireguard_record_name
  value = oci_core_instance.casadora_instance.public_ip
  type = "A"
  ttl = "1"
  proxied = false
}

resource "cloudflare_record" "portainer" {
  zone_id = data.cloudflare_zones.domain.zones[0].id
  name = var.cf_portainer_record_name
  value = oci_core_instance.casadora_instance.public_ip
  type = "A"
  ttl = "1"
  proxied = false
}



