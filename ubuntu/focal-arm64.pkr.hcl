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

locals {
  builds_directory = "${path.root}/../builds"
  password         = "vagrant"
  # Generated via: printf vagrant | openssl passwd -6 -salt vagrant -stdin
  password_crypted    = "$6$vagrant$aYdZwu4306HGdE39rROOrbSnB8G1Jser5zc9VMESSr8PouIZdgoO.OYQsFTOHXRXSYzB1oCD7571llAG6WR15."
  templates_directory = "${path.root}/../templates"
  username            = "vagrant"
  vm_name             = "ubuntu-focal-arm64"
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
      password_crypted = local.password_crypted
      hostname         = local.vm_name
      username         = local.username
    })
  }
  iso_checksum           = "sha256:d6fea1f11b4d23b481a48198f51d9b08258a36f6024cb5cec447fe78379959ce"
  iso_url                = "https://cdimage.ubuntu.com/releases/20.04/release/ubuntu-20.04.3-live-server-arm64.iso"
  memory                 = var.memory
  output_directory       = "${local.builds_directory}/pvm/${local.vm_name}"
  parallels_tools_flavor = "lin-arm"
  shutdown_command       = "echo '${local.password}' | sudo -S shutdown -P now"
  ssh_password           = local.password
  ssh_timeout            = "10000s"
  ssh_username           = local.username
  vm_name                = local.vm_name
}

build {
  sources = [
    "sources.parallels-iso.parallels"
  ]

  post-processor "vagrant" {
    keep_input_artifact  = true
    output               = "${local.builds_directory}/box/${local.vm_name}.box"
    vagrantfile_template = "${local.templates_directory}/Vagrantfile.pkrtpl"
  }
}
