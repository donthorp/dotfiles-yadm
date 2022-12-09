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

## Prepare to Bootstrap

### Install `yadm`

```bash
sudo apt update && sudo apt install yadm
```

