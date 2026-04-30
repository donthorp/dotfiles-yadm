#! /usr/bin/env bash

# Naming convention:
#   artemisNN   — desktop workstation
#   borosNN     — laptop workstation
#   vedfolnirNN — inference desktop
#   xx90-99     — test/dev machines in each class

current=$(hostname -s)
echo "Current hostname: $current"
read -rp "New hostname (leave blank to keep '$current'): " new_hostname

if [[ -n "$new_hostname" && "$new_hostname" != "$current" ]]; then
  sudo hostnamectl set-hostname "$new_hostname"
  echo "Hostname set to: $new_hostname"
else
  echo "Keeping hostname: $current"
fi

which yadm > /dev/null

if [ $? -eq 1 ]; then
  sudo apt update
  sudo apt upgrade -y
  sudo apt install -y yadm
fi

# Generate new github key pair for this machine

KEYFILE=~/.ssh/`hostname`-github -N ""
PUBKEYFILE=~/.ssh/`hostname`-github.pub
CONFIGFILE=~/.ssh/config.d/github.com

if [ ! -f "$KEYFILE" ]; then

  ssh-keygen -t ed25519 -C "don@donthorp.net" -f ~/.ssh/`hostname`-github -N ""

  if [ ! -d "~/.ssh/config.d" ]; then
    mkdir -p ~/.ssh/config.d
    chmod 700 ~/.ssh/config.d
  fi

  if [ ! -f "$CONFIGFILE" ]; then

    cat > $CONFIGFILE <<- EOF
	Host github.com
	  User git
	  Port 22
	  Hostname github.com
	  IdentityFile $PUBKEYFILE 
	  TCPKeepAlive yes
	  IdentitiesOnly yes
	  AddKeysToAgent yes
	EOF
  fi

  echo Visit https://github.com/settings/keys and add this machines public key
  cat $PUBKEYFILE 
  
fi

