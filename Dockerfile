FROM debian:trixie

SHELL ["/bin/bash", "-xueo", "pipefail", "-c"]

ARG TARGETARCH
ARG DEBIAN_FRONTEND=noninteractive

ENV LANG="C.UTF-8"
ENV pip_packages="ansible cryptography"

# Install dependencies.
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked,id=apt-cache-"$TARGETARCH" \
    rm -f /etc/apt/apt.conf.d/docker-clean \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
       sudo systemd systemd-sysv \
       build-essential wget libffi-dev libssl-dev procps \
       python3-pip python3-dev python3-setuptools python3-wheel python3-apt \
       iproute2 dbus \
    && rm -rf /var/lib/apt/lists/* \
    && rm -Rf /usr/share/doc && rm -Rf /usr/share/man

# Allow installing stuff to system Python.
RUN rm -f /usr/lib/python3.13/EXTERNALLY-MANAGED

# Upgrade pip to latest version.
RUN pip3 install --upgrade --ignore-installed pip

# Install Ansible via pip.
RUN pip3 install $pip_packages

COPY initctl_faker .
RUN chmod +x initctl_faker && rm -fr /sbin/initctl && ln -s /initctl_faker /sbin/initctl

# Install Ansible inventory file.
RUN mkdir -p /etc/ansible
RUN echo "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts

# Make sure systemd doesn't start agettys on tty[1-6].
RUN rm -f /lib/systemd/system/multi-user.target.wants/getty.target

VOLUME ["/sys/fs/cgroup"]
CMD ["/lib/systemd/systemd"]
