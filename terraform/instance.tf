data "oci_core_images" "ubuntu" {
  compartment_id = var.oci_tenancy_ocid
  operating_system = "Canonical Ubuntu"
  operating_system_version = "20.04"
  state = "AVAILABLE"
  shape = var.oci_instance_shape
  sort_by = "TIMECREATED"
  sort_order = "DESC"
}

data "oci_identity_availability_domains" "ads" {
  compartment_id = var.oci_tenancy_ocid
}

resource "oci_core_instance" "casadora_instance" {
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id = var.oci_tenancy_ocid
  shape = var.oci_instance_shape
  display_name = var.oci_instance_name
  source_details {
    boot_volume_size_in_gbs = var.oci_instance_boot_volume_size_in_gbs
    source_id = data.oci_core_images.ubuntu.images[0].id
    source_type = "image"
  }
  shape_config {
    memory_in_gbs = var.oci_instance_memory_in_gbs
    ocpus = var.oci_instance_ocpus
  }
  create_vnic_details {
        subnet_id = oci_core_subnet.casadora_public_subnet.id
        assign_public_ip = true
    }
    metadata = {
        ssh_authorized_keys = file(var.oci_ssh_public_key_path)
    } 
  preserve_boot_volume = false

  provisioner "remote-exec" {
    inline = ["echo SSH Connection Successful"]

    connection {
      host        = self.public_ip
      type        = "ssh"
      user        = "ubuntu"
      agent       = true
    }
  }

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ubuntu -i '${self.public_ip},' --private-key ${var.ansible_ssh_private_key_path} housekeeping.yml"
    working_dir = "../ansible"
  }
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ubuntu -i '${self.public_ip},' --private-key ${var.ansible_ssh_private_key_path} setup-services.yml"
    working_dir = "../ansible"
    environment = {
      traefik_username = var.ansible_traefik_username
      traefik_password = var.ansible_traefik_password
      lets_encrypt_email = var.ansible_lets_encrypt_email
      base_domain = var.cf_domain_name
      cf_api_token = var.cf_api_token
      traefik_sub_domain = var.cf_traefik_record_name
      adguard_sub_domain = var.cf_adguard_record_name
      adguard_username = var.ansible_adguard_username
      adguard_password = var.ansible_adguard_password
      grafana_sub_domain = var.cf_grafana_record_name
      heimdall_sub_domain = var.cf_heimdall_record_name
      wireguard_sub_domain = var.cf_wireguard_record_name
      wireguard_password = var.ansible_wireguard_password
      wireguard_host_ip = self.public_ip
      portainer_sub_domain = var.cf_portainer_record_name
    }
  }

  

}

/* data "oci_core_private_ips" "casadora_private_ips" {
    ip_address = oci_core_instance.casadora_instance.private_ip
    subnet_id = oci_core_subnet.casadora_public_subnet.id
}

resource "oci_core_public_ip" "casadora_public_ip" {
    compartment_id = var.oci_tenancy_ocid
    lifetime = var.oci_public_ip_lifetime
    private_ip_id = data.oci_core_private_ips.casadora_private_ips.private_ips[0]["id"]
    display_name = var.oci_public_ip_display_name

} */