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

variable "password" {
  default   = "vagrant"
  sensitive = true
  type      = string
}

variable "password_crypted" {
  # Generated via: printf vagrant | openssl passwd -6 -salt vagrant -stdin
  default   = "$6$vagrant$aYdZwu4306HGdE39rROOrbSnB8G1Jser5zc9VMESSr8PouIZdgoO.OYQsFTOHXRXSYzB1oCD7571llAG6WR15."
  sensitive = true
  type      = string
}

variable "username" {
  default = "vagrant"
  type    = string
}

variable "vm_name" {
  default = "ubuntu-focal-arm64"
  type    = string
}

locals {
  builds_directory = "${path.root}/../builds"
}

source "parallels-iso" "parallels" {
  boot_command = [
    "<esc>",
    "linux /casper/vmlinuz",
    " quiet",
    " autoinstall",
    " ds='nocloud-net;s=http://{{.HTTPIP}}:{{.HTTPPort}}/'",
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
      password_crypted = var.password_crypted
      hostname         = var.vm_name
      username         = var.username
    })
  }
  iso_checksum           = "sha256:d6fea1f11b4d23b481a48198f51d9b08258a36f6024cb5cec447fe78379959ce"
  iso_url                = "https://cdimage.ubuntu.com/releases/20.04/release/ubuntu-20.04.3-live-server-arm64.iso"
  memory                 = var.memory
  output_directory       = "${local.builds_directory}/pvm/${var.vm_name}"
  parallels_tools_flavor = "lin-arm"
  shutdown_command       = "echo ${var.password} | sudo -S shutdown -P now"
  ssh_password           = var.password
  ssh_timeout            = "10000s"
  ssh_username           = var.username
  vm_name                = var.vm_name
}

build {
  sources = [
    "sources.parallels-iso.parallels"
  ]

  post-processor "vagrant" {
    keep_input_artifact = true
    output              = "${local.builds_directory}/box/${var.vm_name}.box"
  }
}
