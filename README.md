# Dotfiles managed by `yadm`

## Configure Host Name

Use artemisNN for desktop machines.

```bash
sudo hostnamectl set-hostname artemis02
```

Use borosNN for laptops

```bash
sudo hostnamectl set-hostname boros02
```

Use hermesNN for virtual machines

```bash
sudo hostnamectl set-hostname hermes01
```

## Used Names
- boros01,boros01a (rebuild) - Oryx Pro
- artemis01 - Gaming Machine - 23 Aug 2022
- hermes01 - Development VM for new dot files
- artemis02 - Minisforum Desktop UM690 32 GB RAM, 1 TB M2 - 29 Apr 2023

## Bootstrap

### Install `yadm`

```bash
sudo apt update && sudo apt install yadm
```
### Clone this Repository

```bash
yadm clone https://github.com/donthorp/dotfiles-yadm.git
```
> Answer `y` to run the bootstrap

## Create Keys for Github

```bash
~/.bootstrap.sh
```

Visit [Github SSH Keys](https://github.com/settings/keys) and add the public key printed in the terminal session.

