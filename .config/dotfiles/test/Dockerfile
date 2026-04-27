FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
# Override become_ask_pass from ansible.cfg — container user has NOPASSWD sudo
ENV ANSIBLE_BECOME_ASK_PASS=False

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    sudo \
    curl \
    git \
    gnupg \
    software-properties-common \
    && add-apt-repository universe

# Pre-install GPG keys and APT repos that the playbook configures so that
# check-mode can resolve all packages without needing to fetch keys at runtime.
# /var/lib/apt/lists/ is intentionally kept for the same reason.
RUN install -dm755 /etc/apt/keyrings \
    && curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
         -o /etc/apt/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
         > /etc/apt/sources.list.d/github-cli.list \
    && curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
         | gpg --dearmor -o /etc/apt/keyrings/docker.gpg \
    && echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu jammy stable" \
         > /etc/apt/sources.list.d/docker.list \
    && apt-get update

# Non-root user with passwordless sudo, mirroring a real workstation user.
# docker group is pre-created so check-mode can verify the user task without
# docker-ce actually being installed.
RUN groupadd docker && \
    useradd -m -s /bin/bash ansible && \
    echo 'ansible ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER ansible
ENV PATH="/home/ansible/.local/bin:${PATH}"

# Pre-create font directories and sentinel files so check-mode font tasks
# see fonts as already installed and skip the download/extract steps.
RUN mkdir -p /home/ansible/.local/share/fonts \
             /home/ansible/.local/share/fonts/inter \
             /home/ansible/.local/share/fonts/libre-clarendon \
             /home/ansible/.local/bin \
             /home/ansible/.cache/font-downloads \
    && touch /home/ansible/.local/share/fonts/FiraCodeNerdFont-Regular.ttf \
             /home/ansible/.local/share/fonts/inter/Inter.ttc \
             /home/ansible/.local/share/fonts/libre-clarendon/LibreClarendon-Regular.ttf \
             /home/ansible/.local/bin/nvim-linux-x86_64.appimage \
    && chmod 755 /home/ansible/.local/bin/nvim-linux-x86_64.appimage

# Ansible + psutil (required by gnome role tasks)
RUN pip3 install --user ansible psutil

# community.general provides flatpak, snap modules
RUN ansible-galaxy collection install community.general

WORKDIR /ansible
