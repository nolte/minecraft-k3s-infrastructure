data "hcloud_ssh_key" "machine_key" {
  with_selector = "usage=machine"
}

data "hcloud_ssh_key" "private_key" {
  with_selector = "usage=manual"
}

module "minecraft_computing_elements" {
  source = "git::https://github.com/nolte/terraform-infrastructure-modules.git//computing_elements?ref=v0.0.4"

  computing_instance_name                   = "${var.minecraft_computing_instance_name}"
  computing_instance_usage_root_key         = "${data.hcloud_ssh_key.machine_key.id}"
  computing_instance_labels                 = "${var.minecraft_computing_instance_labels}"
  computing_instance_ssh_machine_key_id_var = "${data.hcloud_ssh_key.machine_key.public_key}"
  computing_instance_ssh_private_key_id_var = "${data.hcloud_ssh_key.private_key.public_key}"
  computing_instance_flavour                = "${var.minecraft_computing_instance_flavour}"
  computing_instance_image                  = "centos-8"
}
