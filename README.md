# My Config Setup Sway

This project is an automation script for setting up and configuring Sway, a tiling window manager for Wayland, along with related applications like Rofi, Waybar, and others.

## Description

This script helps you quickly set up and configure Sway and its related applications on a Linux system. It is specifically designed for **Arch Linux** and uses the `pacman` package manager. With this script, you can easily install and configure Sway and supporting utilities.

## Features

- **Automatic Installation**: Installs Sway, Waybar, Rofi, and other related applications.
- **Configuration Backup**: Backs up old configurations before applying new ones.
- **Configuration Management**: Manages and copies configuration files for Sway, Rofi, and Waybar.
- **Style.css Management**: Moves the `style.css` file to the appropriate directory and backs it up if it already exists.

## System Requirements

- A Linux-based operating system with **Wayland** support.
- Sway (tiling window manager).
- Git (for cloning the repository).
- Required tools like `sudo`, `pacman`, `rofi`, `waybar`, and others.

## Installation

### 1. Clone the repository and execute the script

```bash
git clone git@github.com:username/setup-sway.git
cd setup-sway
chmod +x sway-setup.sh
./sway-setup.sh
