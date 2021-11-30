# Packer Templates

## Building Kubeflow

## Building Ubuntu

### Focal ARM64

```bash
packer build ubuntu/focal-arm64.pkr.hcl \
    -var cpus=2 \
    -var memory=1024 \
    -var ssh_password=packer \
    -var ssh_password_crypted=$6$packer$boWUDPn2ItbIVp75vZkcB9enktYcH/yND03ZqeO.xN1ydPY2A8ZRsbTDbbiRlToGQ97O4.AM3Tdw9FQoPk41k. \
    -var ssh_username=packer
```

## Examples of building with Packer

### Virtual Machines

- [Build Base Boxes with Packer](https://parallels.github.io/vagrant-parallels/docs/boxes/packer.html)
- [github/chef/bentu](https://github.com/chef/bento)
- [github/tylert/packer-build](https://github.com/tylert/packer-build)

## Notes

- [Install Kubeflow](https://www.kubeflow.org/docs/distributions/aws/deploy/install-kubeflow/)
- [Parallels Builder (from an ISO)](https://www.packer.io/docs/builders/parallels/iso)
- [Using Packer and Vagrant to Build Virtual Machines](https://www.cloudbees.com/blog/packer-vagrant-tutorial)

## TODO

- Automate crypted password
- Automate `packer fmt`
- Makefile to ease the process
- Maybe install `packer` and other executables local to this repo?
- Consider using Ansible, Chef, or Puppet to actually configure the machines?
- Rename this repo if it is extended beyond the use of Packer
