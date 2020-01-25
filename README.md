
# Minecraft k3s Infrastructure 

This is the [Kubernetes](https://kubernetes.io) Version from the [nolte/minecraft-infrastructure](https://github.com/nolte/minecraft-infrastructure) Project.

## Motivation

We play Minecraft since many years, on the same world, mostly on the latest Spigot Version. Sometimes with more players, othertimes with not so many. So we need a scalable environment with mininmal cost, at not used Time, lets go in the Cloud! ;).

But why is the Classic VM Infrastructure from [nolte/minecraft-infrastructure](https://github.com/nolte/minecraft-infrastructure) not enough?

The Classic VM Project is realy static, you can deploy a simple Minecraft Server and got backups.
Including new Features is ugly, so it needs many changes and complex ansible sources for handle feature flags and more flexibility in our deployment.

So we hope, that the Kubernetes tool Galaxy, handle many of our problems, and make it faster to develop and deploy new Feature Sets, like [feed the beast](https://feed-the-beast.com) ModPacks.


## Features

* Install Container Based Minecraft Server (Based on [itzg/docker-minecraft-server](https://github.com/itzg/docker-minecraft-server))
* Provide Different Stages
  * Local Dev Stage with a set of Utility services like Minio
  * a Production Environment, controlled with [Terraform](https://www.terraform.io) and [Ansible](https://ansible.com), hosted at the [hetzner.de/cloud](https://hetzner.de/cloud)
* Monitoring with Prometheus Stack
* Combine different Ansible roles for os hardening, like (sshd, fail2ban, logrotate, restic) ([nolte/ansible_playbook-baseline-online-server](https://github.com/nolte/ansible_playbook-baseline-online-server)). 

## Usage

This Repository can be used to Provide your Server on two different Platforms Vagrant and Hetzner Cloud. 

### Local Development

For the local development use the local [Vagrant](https://vagrantup.com) Infrastructure, located at ```./local```.

```bash
  cd ./local
  vagrant up
```

### Online Development

For the [hetzner.de/cloud](https://hetzner.de/cloud) Deployment take a look to the Terraform Infrastructure Part.

### Provide the Infrastructrue

```bash

cd ./src/infrastructure/computing

 export HCLOUD_TOKEN_STORAGE_PROJECT=$(pass internet/hetzner.com/projects/personal_storage/token) && \
   export HCLOUD_TOKEN=$(pass internet/hetzner.com/projects/minecraft/terraform-token) && \
   export AWS_ACCESS_KEY_ID=$(pass internet/project/mystoragebox/minio_access_key) && \
   export AWS_SECRET_ACCESS_KEY=$(pass internet/project/mystoragebox/minio_secret_key) && \
   export AWS_S3_ENDPOINT=https://$(curl -s -H "Authorization: Bearer $HCLOUD_TOKEN_STORAGE_PROJECT" 'https://api.hetzner.cloud/v1/servers?name=storagenode' | jq -r '.servers[0].public_net.ipv4.dns_ptr')

```

### Rollout the Service

**Full Rollout**
```bash
# use your own Ansible Inventory
export ANSIBLE_INVENTORY=$(pwd)/minecraft-k3s

cd ./src/maintenance

# check connection
ansible all -m ping

# install required galaxy dependencies from src/maintenance/roles/ folder
ansible-galaxy install -r ./roles/requirements.yml

# call the Master playbook for full configuration
ansible-playbook master_playbook-full-install.yml

```


*WIP*
