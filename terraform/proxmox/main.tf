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


resource "proxmox_virtual_environment_vm" "ubuntu_clone" {
  count     = 1
  name      = "ubuntu-clone-${count.index + 1}"
  node_name = var.target_node
  started     = false

  clone {
    vm_id = 900
  }

  agent {
    # NOTE: The agent is installed and enabled as part of the cloud-init configuration in the template VM, see cloud-config.tf
    # The working agent is *required* to retrieve the VM IP addresses.
    # If you are using a different cloud-init configuration, or a different clone source
    # that does not have the qemu-guest-agent installed, you may need to disable the `agent` below and remove the `vm_ipv4_address` output.
    # See https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_vm#qemu-guest-agent for more details.
    enabled = true
  }

  memory {
    dedicated = 768
  }

}