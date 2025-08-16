variable "pm_endpoint" {
  description = "URL of the Proxmox endpoint"
  type        = string
}

variable "pm_user" {
  description = "Proxmox username"
  type        = string
}

variable "pm_password" {
  description = "Proxmox password"
  type        = string
  sensitive   = true
}

variable "vm_name" {
  description = "Name of the virtual machine"
  type        = string
}

variable "template_name" {
  description = "Proxmox template name to clone from"
  type        = string
}

variable "target_node" {
  description = "Proxmox node to create the VM on"
  type        = string
}

variable "vm_id" {
  description = "Unique VM ID"
  type        = number
}

variable "vm_memory" {
  default     = 2048
  description = "Amount of memory in MB"
  type        = number
}

variable "vm_cores" {
  default     = 2
  description = "Number of CPU cores"
  type        = number
}

variable "ansiblekey_pub" {
  description = "public key for the ansibleusr"
  sensitive   = true
  type        = string
}

variable "tsig_key" {
  type        = string
  sensitive   = true
}

variable "vm_configs" {
  type = map(object({
    name       = string
    node       = string
    started    = bool
    clone_id   = number
    memory     = number
    cores      = number
    bridge     = string
    nic_model  = string
    ipv4conf   = string
    user       = string
    password   = string
  }))
}