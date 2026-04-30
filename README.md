# Dotfiles managed by `yadm`

## Configure Host Name

| Class | Hardware | Naming | Test/Dev |
|---|---|---|---|
| artemis | desktop workstation | artemisNN | artemis90–99 |
| boros | laptop workstation | borosNN | boros90–99 |
| vedfolnir | inference desktop | vedfolnirNN | vedfolnir90–99 |

Suffix 90–99 is reserved for test and development machines in each class.

```bash
sudo hostnamectl set-hostname artemis01   # example
```

## Used Names

### artemis — desktop workstations
- artemis01 - Gaming Machine (Pop!_OS, GNOME) - 23 Aug 2022
- artemis02 - Minisforum UM690, 32 GB RAM, 1 TB M.2 (Pop!_OS, GNOME) - 29 Apr 2023
- artemis90 - GNOME Boxes test VM (Pop!_OS 22.04, GNOME) - Apr 2026

### boros — laptop workstations
- boros01, boros01a (rebuild) - System76 Oryx Pro
- boros02 - laptop workstation (Pop!_OS, GNOME)
- boros03 - Framework 13 AMD (Pop!_OS, GNOME) - 12 Nov 2025

### vedfolnir — inference desktops
- vedfolnir00 - Framework Desktop, Ryzen AI Max+ 395 (Pop!_OS 24.04, COSMIC) - 2026

### retired
- hermes01 - Development VM (hermes naming retired; use xx90–99 convention)

## Bootstrap

### Update the system in case you need to fix broken installs, etc

```bash
sudo apt update && sudo apt upgrade -y
```
### Install `yadm`
```bash
sudo apt install yadm
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
### In a new Session
Apparently we have to authenticate at least once before the key allows push.
```bash
ssh -T github.com
```
### Finish initial YDAM Setup
```bash
yadm bootstrap
```
## Claude Code

Install after bootstrap (Node.js is pulled in by the common play):

```bash
npm install -g @anthropic/claude-code
```

A standalone installer that bundles its own Node.js runtime is also available — see the [Claude Code documentation](https://docs.anthropic.com/en/docs/claude-code) if npm is not yet available on the machine.

Project memory and settings are already in place from yadm — no extra setup needed after install.

## VM / GNOME Boxes

### Display resolution (SPICE)

On a fresh VM **before** running bootstrap, the display may appear as a small fixed-size square. Fix it manually before cloning:

```bash
sudo apt install spice-vdagent
```

Log out and back in. GNOME Boxes will auto-resize the display to match the window from that point on.

> Bootstrap handles this automatically on subsequent bootstraps — `000-Virtual-Machine-Drivers` installs `spice-vdagent` and `spice-webdavd` when it detects QEMU hardware.

### YADM Diff Issue

If there is a conflict in `.bashrc` you **might** need to checkout .bashrc specifically to solve it and get any updates made remotely.

```bash
yadm checkout .bashrc
yadm pull
```
