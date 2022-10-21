#! /usr/bin/env bash

# Generate new github key pair for this machine

#ssh-keygen -t ed25519 -C "don@donthorp.net" -f ~/.ssh/`hostname`-github -N ""
#mkdir -p ~/.ssh/config.d
#chmod 700 ~/.ssh/config.d

cat > ~/.ssh/config.d/github.com << EOF
Host github.com
  User git
  Port 22
  Hostname github.com
  IdentityFile ~/.ssh/`hostname`-github.pub
  TCPKeepAlive yes
  IdentitiesOnly yes
  AddKeysToAgent yes
EOF

cat > ~/.gitconfig << GIT
[user]
	email = don@donthorp.net
	name = Don Thorp
[pull]
	ff = only
	rebase = true
GIT

echo Visit https://github.com/settings/keys and add this machines public key
cat ~/.ssh/`hostname`-github.pub
