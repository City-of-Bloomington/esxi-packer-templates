# Packer Templates for VMware ESXi
## Overview
This repository contains definitions to be used with [Packer].

They require the JetBrains [packer-builder-vsphere-iso] module to be in the current directory to successfully build the images.

I have removed as much customization for our environment as possible from the templates, but there are likely still a few pieces of our environment laying around that may need to be worked around if you attempt to use these without modification.

## Configuration
Make a copy of the .example json files and remove the .example extension, then configure the options accordingly.

You will also need to specify the ISO path in the debian.json or ubuntu.json files.

## Building
To build an image, either use the included `debian.sh` or `ubuntu.sh` scripts or manually run packer like so:
```
packer build -var-file=secret.json -var-file=env.json debian/debian.json
```
After the installation process is complete, a few scripts will be executed to apply various fixes and customizations. The final step is running the `sysprep` script which resets the machine-id (to prevent DHCP conflicts) in addition to clearing logs and SSH keys.

## Things to keep in mind
A few assumptions are made, seeing as this is intended to be used in our production environment. Change these as necessary.
* The default username is `champ` and there is no root account.
* The password during the installation is simply the name of the distro (`debian`,`ubuntu`) and is reset upon running `sysprep` at the end of the run.
   * Changing the username and password will require adjustment of the provisioners section and scripts.
* You have a kickstart/preseed file named the same as the ones outlined in the .json files
* The MOTD will be customized using an update-motd script called `20-cob` and placed in /etc/update-motd.d/

[Packer]: https://packer.io
[packer-builder-vsphere-iso]: https://github.com/jetbrains-infra/packer-builder-vsphere/releases