FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
# Override become_ask_pass from ansible.cfg — container user has NOPASSWD sudo
ENV ANSIBLE_BECOME_ASK_PASS=False

# Enable universe repo (required for ack, git-extras, fzf, etc.)
# Keep apt lists — this is a test image, not production, and Ansible
# needs them to resolve packages during --check dry-runs.
RUN apt-get update && apt-get install -y software-properties-common \
    && add-apt-repository universe \
    && apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    sudo \
    curl \
    git

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
