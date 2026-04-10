FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
# Override become_ask_pass from ansible.cfg — container user has NOPASSWD sudo
ENV ANSIBLE_BECOME_ASK_PASS=False

# System packages needed by Ansible and common tasks
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    sudo \
    curl \
    git \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# Non-root user with passwordless sudo, mirroring a real workstation user
RUN useradd -m -s /bin/bash ansible && \
    echo 'ansible ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER ansible
ENV PATH="/home/ansible/.local/bin:${PATH}"

# Ansible + psutil (required by gnome role tasks)
RUN pip3 install --user ansible psutil

# community.general provides flatpak, snap modules
RUN ansible-galaxy collection install community.general

WORKDIR /ansible
