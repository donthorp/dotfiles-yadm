#! /usr/bin/env bash

# Please set the hostname of the machine BEFORE bootstrapping

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

