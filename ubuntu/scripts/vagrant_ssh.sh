#!/bin/sh -eux

home_dir="${HOME_DIR:-/home/vagrant}"

# Install the insecure public key:
# https://www.vagrantup.com/docs/boxes/base#vagrant-user
vagrant_pub_url="https://raw.githubusercontent.com/hashicorp/vagrant/main/keys/vagrant.pub"
mkdir -p $home_dir/.ssh
wget --no-check-certificate "${vagrant_pub_url}" -O $home_dir/.ssh/authorized_keys
chown -R vagrant $HOME_DIR/.ssh
chmod -R go-rwsx $HOME_DIR/.ssh

# Disable UseDNS to speed up SSH:
# https://www.vagrantup.com/docs/boxes/base#ssh-tweaks
sshd_config="/etc/ssh/sshd_config"
sed -i "s/^\s*UseDNS.*/UseDNS no/" "${sshd_config}"
sed -i "s/^\s*GSSAPIAuthentication.*/GSSAPIAuthentication no/" "${sshd_config}"