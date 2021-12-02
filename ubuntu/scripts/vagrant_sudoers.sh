#!/bin/sh -eux

# Setting up password-less sudo:
# https://www.vagrantup.com/docs/boxes/base#vagrant-user
echo "vagrant ALL=(ALL) NOPASSWD: ALL" | sudo EDITOR="tee -a" visudo
