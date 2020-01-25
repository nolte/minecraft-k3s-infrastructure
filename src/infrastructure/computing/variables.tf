variable "minecraft_computing_instance_name" {
  default = "mc-k3s"
}
variable "minecraft_computing_instance_flavour" {
  default = "cx21"
}

variable "minecraft_storage_hot_backup_active" {
  default = true
}

variable "minecraft_computing_instance_labels" {
  type = "map"
  default = {
    stage   = "dev"
    service = "minecraft-k3s"
    state   = "active"
  }
}