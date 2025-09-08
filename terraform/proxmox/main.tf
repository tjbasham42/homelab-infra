terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.80.0"
    }
    dns = {
      source = "hashicorp/dns"
      version = "3.4.3"
    }
  }
}

provider "dns" {
  update {
    server        = "192.168.2.1"
    key_name      = "tsig-key."
    key_algorithm = "hmac-sha256"
    key_secret    = var.tsig_key
  }
}

provider "proxmox" {
  endpoint = var.pm_endpoint

  # TODO: use terraform variable or remove the line, and use PROXMOX_VE_USERNAME environment variable
  username = var.pm_user
  # TODO: use terraform variable or remove the line, and use PROXMOX_VE_PASSWORD environment variable
  password = var.pm_password

  # because self-signed TLS certificate is in use
  insecure = true
  # uncomment (unless on Windows...)
  # tmp_dir  = "/var/tmp"

  ssh {
    agent = true
    # TODO: uncomment and configure if using api_token instead of password
    # username = "root"
  }
}

resource "proxmox_virtual_environment_vm" "vms" {
  for_each  = var.vm_configs
  name      = each.value.name
  node_name = each.value.node
  started   = each.value.started

  clone {
    vm_id = each.value.clone_id
  }

  memory {
    dedicated = each.value.memory
  }

  cpu {
    cores = each.value.cores
  }

  network_device {
    bridge = each.value.bridge
    model  = each.value.nic_model
  }

  initialization {
    user_account {
      username = each.value.user
      password = each.value.password
      keys      = [trimspace(tls_private_key.ubuntu_vm_key.public_key_openssh)]
    }

    dns {
      domain = "odnops.com"
      servers = ["192.168.2.1","192.168.0.1"]
    }
    ip_config {
      ipv4 {
        address = each.value.ipv4conf
        gateway = each.value.ipv4conf == "dhcp" ? null : "192.168.0.1"
      }
    }
  }
}

resource "tls_private_key" "ubuntu_vm_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "dns_a_record_set" "host_records" {
  for_each  = proxmox_virtual_environment_vm.vms

  zone      = "odnops.com."
  name      = each.value.name
  addresses = [
    each.value.ipv4_addresses[1][0]
  ]
  ttl       = 300

  depends_on = [
    proxmox_virtual_environment_vm.vms
  ]
}

resource "dns_cname_record" "traefik_dashboard" {
  zone = "odnops.com."
  name = "traefik-dashboard"
  cname = "dockertraefik.odnops.com."
  ttl = 300
}

resource "dns_cname_record" "mario_record" {
  zone = "odnops.com."
  name = "mario"
  cname = "dockertraefik.odnops.com."
  ttl = 300
}

output "ubuntu_vm_private_key" {
  value     = tls_private_key.ubuntu_vm_key.private_key_pem
  sensitive = true
}

output "ubuntu_vm_public_key" {
  value = tls_private_key.ubuntu_vm_key.public_key_openssh
}