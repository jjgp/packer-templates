packer {
  required_version = "~> 1.7.8"
}

variable "ssh_password" {
  default   = "packer"
  sensitive = true
  type      = string
}

variable "ssh_password_crypted" {
  # Generated via: printf packer | mkpasswd -m sha-512 -S hashicorp. -s
  default   = "$6$hashicorp.$Wp1yBotkpPDzeT24N/1zmPsPHOtjk3lsefRnU/Ro0ekdIPEel/9SSUZ.hQlBRST.hkUhqOKIIGsoQBmVPiF3N0"
  sensitive = true
  type      = string
}

variable "ssh_username" {
  default = "packer"
  type    = string
}

locals {
  output_directory = "build/${formatdate("DDMMYYYY-hhmmss", timestamp())}"
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
  cpus          = 2
  guest_os_type = "ubuntu"
  http_content = {
    "/meta-data" = file("http/meta-data")
    # Reference: https://www.hashicorp.com/blog/using-template-files-with-hashicorp-packer
    "/user-data" = templatefile("http/user-data.pkrtpl", {
      crypted_password = var.ssh_password_crypted
      username = var.ssh_username
      vm_name = "ubuntu-focal-arm64"
    })
  }
  iso_checksum           = "sha256:d6fea1f11b4d23b481a48198f51d9b08258a36f6024cb5cec447fe78379959ce"
  iso_url                = "https://cdimage.ubuntu.com/releases/20.04/release/ubuntu-20.04.3-live-server-arm64.iso"
  memory                 = 1024
  output_directory       = local.output_directory
  parallels_tools_flavor = "lin-arm"
  shutdown_command       = "echo 'packer' | sudo -S shutdown -P now"
  ssh_password           = var.ssh_password
  ssh_username           = var.ssh_username
  ssh_timeout            = "10000s"
  vm_name                = "ubuntu-focal-arm64"
}

build {
  sources = [
    "sources.parallels-iso.ubuntu-focal-arm64"
  ]
}