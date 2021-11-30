packer {
  required_version = "~> 1.7.8"
}

variable "cpus" {
  default = 2
  type    = number
}

variable "memory" {
  default = 1024
  type    = number
}

variable "ssh_password" {
  default   = "packer"
  sensitive = true
  type      = string
}

variable "ssh_password_crypted" {
  # Generated via: printf packer | openssl passwd -6 -salt packer -stdin
  default   = "$6$packer$boWUDPn2ItbIVp75vZkcB9enktYcH/yND03ZqeO.xN1ydPY2A8ZRsbTDbbiRlToGQ97O4.AM3Tdw9FQoPk41k."
  sensitive = true
  type      = string
}

variable "ssh_username" {
  default = "packer"
  type    = string
}

source "parallels-iso" "ubuntu-focal-arm64" {
  boot_command = [
    "<esc>",
    "linux /casper/vmlinuz",
    " quiet",
    " autoinstall",
    " ds='nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/'",
    "<enter>",
    "initrd /casper/initrd<enter>",
    "boot<enter>"
  ]
  boot_wait     = "5s"
  cpus          = var.cpus
  guest_os_type = "ubuntu"
  http_content = {
    "/meta-data" = file("http/meta-data")
    # Reference: https://www.hashicorp.com/blog/using-template-files-with-hashicorp-packer
    "/user-data" = templatefile("http/user-data.pkrtpl", {
      crypted_pass = var.ssh_password_crypted
      hostname     = source.name
      username     = var.ssh_username
    })
  }
  iso_checksum           = "sha256:d6fea1f11b4d23b481a48198f51d9b08258a36f6024cb5cec447fe78379959ce"
  iso_url                = "https://cdimage.ubuntu.com/releases/20.04/release/ubuntu-20.04.3-live-server-arm64.iso"
  memory                 = var.memory
  output_directory       = "${path.root}/build/${source.name}"
  parallels_tools_flavor = "lin-arm"
  shutdown_command       = "echo 'packer' | sudo -S shutdown -P now"
  ssh_password           = var.ssh_password
  ssh_username           = var.ssh_username
  ssh_timeout            = "10000s"
  vm_name                = source.name
}

build {
  sources = [
    "sources.parallels-iso.ubuntu-focal-arm64"
  ]
}
