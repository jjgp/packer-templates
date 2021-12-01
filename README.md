# Packer Templates

## Building Kubeflow

## Building Ubuntu

### Focal ARM64

```bash
packer build ubuntu/focal-arm64.pkr.hcl \
    -var cpus=2 \
    -var memory=1024 \
    -var password=vagrant \
    -var password_crypted=$6$vagrant$aYdZwu4306HGdE39rROOrbSnB8G1Jser5zc9VMESSr8PouIZdgoO.OYQsFTOHXRXSYzB1oCD7571llAG6WR15. \
    -var username=vagrant \
    -var vm_name=ubuntu-focal-arm64
```

## Examples of building with Packer

### Virtual Machines

- [Build Base Boxes with Packer](https://parallels.github.io/vagrant-parallels/docs/boxes/packer.html)
- [github/chef/bentu](https://github.com/chef/bento)
- [github/rodm/packer-templates](https://github.com/rodm/packer-templates)
- [github/tylert/packer-build](https://github.com/tylert/packer-build)

## Notes

- [Install Kubeflow](https://www.kubeflow.org/docs/distributions/aws/deploy/install-kubeflow/)
- [Parallels Builder (from an ISO)](https://www.packer.io/docs/builders/parallels/iso)
- [Using Packer and Vagrant to Build Virtual Machines](https://www.cloudbees.com/blog/packer-vagrant-tutorial)

```bash
vagrant ssh-config
```

```bash
vagrant box add my-box my-box.box
vagrant init my-box
vagrant up
```

## TODO

- Automate crypted password
- Automate `packer fmt`
- Makefile or CLI to ease the process
- Maybe install `packer` and other executables local to this repo?
- Consider using Ansible, Chef, or Puppet to actually configure the machines?
- Rename this repo if it is extended beyond the use of Packer
