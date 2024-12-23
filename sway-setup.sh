#!/bin/bash

# Nama file konfigurasi Sway
CONFIG_DIR="$HOME/.config/sway"
CONFIG_DIR_ROFI="$HOME/.config/rofi"
CONFIG_DIR_WAYBAR="$HOME/.config/waybar"

# Warna untuk output
GREEN="\033[0;32m"
NC="\033[0m" # No Color

echo -e "${GREEN}Memulai setup Sway...${NC}"

# 1. Pastikan sistem terupdate
echo -e "${GREEN}Memperbarui sistem...${NC}"
sudo pacman -Syu --noconfirm
if [ $? -ne 0 ]; then
  echo -e "${GREEN}Pembaharuan sistem gagal! Menghentikan skrip...${NC}"
  exit 1
fi

# 2. Instalasi Sway dan paket tambahan
echo -e "${GREEN}Menginstal Sway dan paket tambahan...${NC}"
sudo pacman -S --noconfirm sway swaybg waybar wl-clipboard polkit-gnome xdg-desktop-portal-wlr swaylock swaync blueman bluez bluez-utils gammastep networkmanager network-manager-applet polkit rofi autotiling
if [ $? -ne 0 ]; then
  echo -e "${GREEN}Instalasi gagal! Menghentikan skrip...${NC}"
  exit 1
fi

# 3. Membuat direktori konfigurasi jika belum ada
echo -e "${GREEN}Membuat direktori konfigurasi untuk Sway...${NC}"
if [ ! -d "$CONFIG_DIR" ]; then
  echo -e "${GREEN}Direktori Sway tidak ditemukan. Membuat direktori...${NC}"
  mkdir -p "$CONFIG_DIR"
  echo -e "${GREEN}Mencopy dan menyalin semua isi dari direktori konfigurasi untuk Sway...${NC}"
  cp -r ./.config/sway "$CONFIG_DIR"
else
  echo -e "${GREEN}Direktori Sway sudah ada. Apakah Anda ingin menggantinya? (y/n)${NC}"
  read -r answer
  if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
    if [ -d "$CONFIG_DIR-bak" ]; then
      echo -e "${GREEN}Direktori backup Sway sudah ada, melewatkan penggantian direktori...${NC}"
    else
      mv "$CONFIG_DIR" "$CONFIG_DIR-bak"
      echo -e "${GREEN}Mencopy dan menyalin semua isi dari direktori konfigurasi untuk Sway...${NC}"
      cp -r ./.config/sway "$CONFIG_DIR"
    fi
  else
    echo -e "${GREEN}Tidak mengganti konfigurasi Sway.${NC}"
  fi
fi

# Konfigurasi Rofi
echo -e "${GREEN}Membuat direktori konfigurasi untuk Rofi...${NC}"
if [ ! -d "$CONFIG_DIR_ROFI" ]; then
  mkdir -p "$CONFIG_DIR_ROFI"
  echo -e "${GREEN}Mencopy semua isi dari direktori konfigurasi untuk Rofi...${NC}"
  cp -r ./.config/rofi "$CONFIG_DIR_ROFI"
else
  echo -e "${GREEN}Direktori Rofi sudah ada. Apakah Anda ingin menggantinya? (y/n)${NC}"
  read -r answer
  if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
    if [ -d "$CONFIG_DIR_ROFI-bak" ]; then
      echo -e "${GREEN}Direktori backup Rofi sudah ada, melewatkan penggantian direktori...${NC}"
    else
      mv "$CONFIG_DIR_ROFI" "$CONFIG_DIR_ROFI-bak"
      echo -e "${GREEN}Mencopy semua isi dari direktori konfigurasi untuk Rofi...${NC}"
      cp -r ./.config/rofi "$CONFIG_DIR_ROFI"
    fi
  else
    echo -e "${GREEN}Tidak mengganti konfigurasi Rofi.${NC}"
  fi
fi

# Konfigurasi Waybar
echo -e "${GREEN}Membuat direktori konfigurasi untuk Waybar...${NC}"
if [ ! -d "$CONFIG_DIR_WAYBAR" ]; then
  mkdir -p "$CONFIG_DIR_WAYBAR"
  echo -e "${GREEN}Mencopy semua isi dari direktori konfigurasi untuk Waybar...${NC}"
  cp -r ./.config/waybar "$CONFIG_DIR_WAYBAR"
else
  echo -e "${GREEN}Direktori Waybar sudah ada. Apakah Anda ingin menggantinya? (y/n)${NC}"
  read -r answer
  if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
    if [ -d "$CONFIG_DIR_WAYBAR-bak" ]; then
      echo -e "${GREEN}Direktori backup Waybar sudah ada, melewatkan penggantian direktori...${NC}"
    else
      mv "$CONFIG_DIR_WAYBAR" "$CONFIG_DIR_WAYBAR-bak"
      echo -e "${GREEN}Mencopy semua isi dari direktori konfigurasi untuk Waybar...${NC}"
      cp -r ./.config/waybar "$CONFIG_DIR_WAYBAR"
    fi
  else
    echo -e "${GREEN}Tidak mengganti konfigurasi Waybar.${NC}"
  fi
fi

# 5. Menyelesaikan setup
echo -e "${GREEN}Setup selesai!${NC}"
