vm_configs = {
  "vm01" = {
    name      = "web-server"
    node      = "nuc01"
    started   = true
    clone_id  = 900
    memory    = 1024
    cores     = 2
    bridge    = "vmbr0"
    nic_model = "virtio"
    user      = "webadmin"
    password  = "changeme"
  }

  "vm02" = {
    name      = "db-server"
    node      = "nuc01"
    started   = false
    clone_id  = 900
    memory    = 2048
    cores     = 4
    bridge    = "vmbr0"
    nic_model = "virtio"
    user      = "dbadmin"
    password  = "secret"
  }
}