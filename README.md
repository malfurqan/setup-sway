# My Config Setup Sway

This project is an automation script for setting up and configuring Sway, a tiling window manager for Wayland, along with several related applications such as Rofi, Waybar, and others.

## Description

This script helps you set up and configure Sway on a Linux system, complete with configurations for various supporting applications. By using this script, you can easily install, configure, and migrate your settings for Sway and its associated applications.

The script is designed to work specifically with **Arch Linux** and its package manager, `pacman`, making it an efficient tool for users of Arch-based distributions who want a quick and easy setup for Sway and related utilities.

## Features

- **Automatic Installation**: Installs Sway, Waybar, Rofi, and other related applications.
- **Configuration Backup**: Backs up old configuration files before replacing them with new ones.
- **Configuration Management**: Copies and configures the configuration files for Sway, Rofi, and Waybar.
- **style.css Management**: Moves the `style.css` file to the appropriate directory, backing it up if it already exists.

## System Requirements

- Linux-based operating system (with Wayland support).
- Sway (for tiling window manager).
- Git (for cloning this repository).
- Various related tools like `sudo`, `pacman`, `rofi`, `waybar`, and others.

## Installation

### 1. Clone the repository

```bash
git clone git@github.com:username/setup-sway.git
cd setup-sway
chmod +x sway-setup.sh
./sway-setup.sh
