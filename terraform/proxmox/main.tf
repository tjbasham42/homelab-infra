terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.80.0"
    }
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
    }

    ip_config {
      ipv4 {
        address = each.value.ipv4conf
      }
    }
  }
}
