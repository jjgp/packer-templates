# Packer Templates

![Logo](https://user-images.githubusercontent.com/3421544/144397369-9ad948f5-e5a1-48e4-bd26-68e9ad59e99e.png)

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

- Automate `packer fmt`
- Makefile or CLI to ease the process
