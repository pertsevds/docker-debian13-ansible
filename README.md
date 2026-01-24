# Debian 13 (Trixie) Ansible Test Image

[![Build](https://github.com/geerlingguy/docker-debian12-ansible/actions/workflows/build.yml/badge.svg)](https://github.com/geerlingguy/docker-debian12-ansible/actions/workflows/build.yml) [![Docker pulls](https://img.shields.io/docker/pulls/geerlingguy/docker-debian12-ansible)](https://hub.docker.com/r/geerlingguy/docker-debian12-ansible/)

Debian 13 (Trixie) Docker container for Ansible playbook and role testing.

## Tags

  - `latest`: Latest stable version of Ansible, with Python 3.x.

## How to Build

This image is built on Docker Hub automatically any time the upstream OS container is rebuilt, and any time a commit is made or merged to the `master` branch. But if you need to build the image on your own locally, do the following:

  1. [Install Docker](https://docs.docker.com/engine/installation/).
  2. `cd` into this directory.
  3. Run `docker build -t debian13-ansible .`

## How to Use

  1. [Install Docker](https://docs.docker.com/engine/installation/).
  2. Pull this image from Docker Hub: `docker pull tmp/docker-debian13-ansible:latest` (or use the image you built earlier, e.g. `debian13-ansible`).
  3. Run a container from the image: `docker run --detach --privileged --volume=/sys/fs/cgroup:/sys/fs/cgroup:rw --cgroupns=host tmp/docker-debian13-ansible:latest` (to test my Ansible roles, I add in a volume mounted from the current working directory with ``--volume=`pwd`:/etc/ansible/roles/role_under_test:ro``).
  4. Use Ansible inside the container:
    a. `docker exec --tty [container_id] env TERM=xterm ansible --version`
    b. `docker exec --tty [container_id] env TERM=xterm ansible-playbook /path/to/ansible/playbook.yml --syntax-check`

## 

This is a fork of https://github.com/geerlingguy/docker-debian12-ansible/
