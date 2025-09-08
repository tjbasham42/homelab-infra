vm_configs = {
  "vm01" = {
    name      = "web-server"
    node      = "nuc01"
    started   = true
    clone_id  = 199
    memory    = 1024
    cores     = 2
    bridge    = "vmbr0"
    nic_model = "virtio"
    ipv4conf  = "dhcp"
    user      = "ansibleusr"
    password  = "changeme"
  }

  "vm02" = {
    name      = "db-server"
    node      = "nuc01"
    started   = true
    clone_id  = 199
    memory    = 2048
    cores     = 4
    bridge    = "vmbr0"
    nic_model = "virtio"
    ipv4conf  = "dhcp"
    user      = "ansibleusr"
    password  = "changeme"
  }

  "docker01" = {
    name      = "docker01"
    node      = "nuc01"
    started   = true
    clone_id  = 199
    memory    = 1024
    cores     = 2
    bridge    = "vmbr0"
    nic_model = "virtio"
    ipv4conf  = "dhcp"
    user      = "ansibleusr"
    password  = "changeme"
  }

    "dockerdns" = {
    name      = "dockerdns"
    node      = "nuc01"
    started   = true
    clone_id  = 200
    memory    = 1024
    cores     = 2
    bridge    = "vmbr0"
    nic_model = "virtio"
    ipv4conf  = "192.168.2.1/16"
    user      = "ansibleusr"
    password  = "changeme"
    }

    "dockertraefik" = {
    name      = "dockertraefik"
    node      = "nuc01"
    started   = true
    clone_id  = 200
    memory    = 1024
    cores     = 2
    bridge    = "vmbr0"
    nic_model = "virtio"
    ipv4conf  = "dhcp"
    user      = "ansibleusr"
    password  = "changeme"
    }

    "vault" = {
    name      = "vault"
    node      = "nuc01"
    started   = true
    clone_id  = 199
    memory    = 1024
    cores     = 2
    bridge    = "vmbr0"
    nic_model = "virtio"
    ipv4conf  = "192.168.2.2/16"
    user      = "ansibleusr"
    password  = "changeme"
    }
}