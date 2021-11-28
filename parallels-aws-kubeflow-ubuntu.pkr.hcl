source "parallels-iso" "aws-kubeflow-ubuntu" {
  boot_wait              = "5s"
  guest_os_type          = "ubuntu"
  iso_url                = "https://cdimage.ubuntu.com/focal/daily-live/20211128/focal-desktop-arm64.iso"
  iso_checksum           = "sha256:bfe62927cf616b9e6138b20fe36105f89b0c6ee8cccd0dfe4f22038686b35a4a"
  parallels_tools_flavor = "lin"
  ssh_username           = "packer"
  ssh_password           = "packer"
  ssh_timeout            = "30s"
  shutdown_command       = "echo 'packer' | sudo -S shutdown -P now"
}

build {
  sources = ["sources.parallels-iso.aws-kubeflow-ubuntu"]
}