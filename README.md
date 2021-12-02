![Logo](https://user-images.githubusercontent.com/3421544/144397369-9ad948f5-e5a1-48e4-bd26-68e9ad59e99e.png)

# Packer Templates

## Ubuntu

### Focal ARM64

```bash
packer build ubuntu/focal-arm64.pkr.hcl \
    -var cpus=2 \
    -var memory=1024
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

- Follow advice in https://www.vagrantup.com/docs/boxes/base#default-user-settings
  - Insecure keypair
    - https://github.com/hashicorp/vagrant/tree/main/keys
  - Root password
  - Password-less Sudo
  - SSH tweaks
- https://github.com/chef/bento/blob/main/packer_templates/_common/parallels.sh
- understand other scripts: https://github.com/chef/bento/blob/e5ea77b3ce8b63f461f9f39cbcd03fd8ed4f6334/packer_templates/ubuntu/ubuntu-20.04-arm64.json#L51
- Automate crypted password
- Automate `packer fmt`
- Makefile or CLI to ease the process
- Maybe install `packer` and other executables local to this repo?
- Consider using Ansible, Chef, or Puppet to actually configure the machines?
- Rename this repo if it is extended beyond the use of Packer
