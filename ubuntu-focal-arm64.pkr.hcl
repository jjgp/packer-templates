source "parallels-iso" "ubuntu-focal-arm64" {
  boot_command           = [
    "<esc>",
    "linux /casper/vmlinuz",
    " quiet",
    " autoinstall",
    " ds='nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/'",
    "<enter>",
    "initrd /casper/initrd<enter>",
    "boot<enter>"
  ]
  boot_wait              = "5s"
  cpus                   = 2
  guest_os_type          = "ubuntu"
  http_directory         = "http"
  iso_url                = "https://cdimage.ubuntu.com/releases/20.04/release/ubuntu-20.04.3-live-server-arm64.iso"
  iso_checksum           = "sha256:d6fea1f11b4d23b481a48198f51d9b08258a36f6024cb5cec447fe78379959ce"
  memory                 = 1024
  parallels_tools_flavor = "lin-arm"
  ssh_username           = "packer"
  ssh_password           = "packer"
  ssh_timeout            = "10000s"
  shutdown_command       = "echo 'packer' | sudo -S shutdown -P now"
  vm_name                = "ubuntu-focal-arm64"
}

build {
  sources = [
    "sources.parallels-iso.ubuntu-focal-arm64"
  ]
}