# Debian 13 (Trixie) Ansible Test Image

[![Build](https://github.com/pertsevds/docker-debian13-ansible/actions/workflows/build.yml/badge.svg)](https://github.com/pertsevds/docker-debian13-ansible/actions/workflows/build.yml)

Debian 13 (Trixie) Docker container for Ansible playbook and role testing.

## Packages repo

https://github.com/pertsevds/docker-debian13-ansible/pkgs/container/docker-debian13-ansible

## Tags

  - `latest`: Latest stable version of Ansible, with Python 3.x.

## How to Build

This image is built on Docker Hub automatically any time the upstream OS container is rebuilt, and any time a commit is made or merged to the `main` branch. But if you need to build the image on your own locally, do the following:

  1. [Install Docker](https://docs.docker.com/engine/installation/).
  2. `cd` into this directory.
  3. Run `docker build -t debian13-ansible .`

## How to Use

  Use it with [Molecule](https://github.com/ansible/molecule)

```yml
dependency:
  name: galaxy

driver:
  name: docker

platforms:
  - name: debian-13
    image: "ghcr.io/pertsevds/docker-debian13-ansible:latest"
    pre_build_image: true
    privileged: true
    command: /lib/systemd/systemd
    cgroupns_mode: host
    tmpfs:
      - /tmp
      - /run
      - /run/lock
    volumes:
      - /sys/fs/cgroup:/sys/fs/cgroup:rw
```
  
  or
  
  1. [Install Docker](https://docs.docker.com/engine/installation/).
  2. Pull this image from Docker Hub: `docker pull ghcr.io/pertsevds/docker-debian13-ansible:latest` (or use the image you built earlier, e.g. `debian13-ansible`).
  3. Run a container from the image: `docker run --detach --privileged --volume=/sys/fs/cgroup:/sys/fs/cgroup:rw --cgroupns=host ghcr.io/pertsevds/docker-debian13-ansible:latest` (to test my Ansible roles, I add in a volume mounted from the current working directory with ``--volume=`pwd`:/etc/ansible/roles/role_under_test:ro``).
  4. Use Ansible inside the container:
    a. `docker exec --tty [container_id] env TERM=xterm ansible --version`
    b. `docker exec --tty [container_id] env TERM=xterm ansible-playbook /path/to/ansible/playbook.yml --syntax-check`

## Notes

This is a fork of https://github.com/geerlingguy/docker-debian12-ansible/
