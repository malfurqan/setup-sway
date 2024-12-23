#!/bin/bash

# Nama file konfigurasi Sway
CONFIG_DIR="$HOME/.config/sway"
CONFIG_DIR_ROFI="$HOME/.config/rofi"
CONFIG_DIR_WAYBAR="$HOME/.config/waybar"
STYLE_CSS_SOURCE="$HOME/setup-sway/style.css"
STYLE_CSS_DEST="/etc/xdg/waybar/style.css"
IMAGE_DIR="$HOME/Downloads/"
IMAGE_FILE="wallpaper-1.png"
IMAGE_SOURCE="$HOME/setup-sway/$IMAGE_FILE"
IMAGE_DEST="$HOME/Downloads/$IMAGE_FILE"
IMAGE_BACKUP="$HOME/Downloads/${IMAGE_FILE%.png}-bak.png"
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

# 5. Menyelesaikan setup dan memindahkan style.css ke /etc/xdg/waybar
echo -e "${GREEN}Memindahkan style.css ke /etc/xdg/waybar...${NC}"

# Periksa apakah file style.css ada di sumber
if [ ! -f "$STYLE_CSS_SOURCE" ]; then
  echo -e "${GREEN}File style.css tidak ditemukan di direktori sumber!${NC}"
  exit 1
fi

# Periksa apakah file style.css sudah ada di /etc/xdg/waybar
if [ -f "$STYLE_CSS_DEST" ]; then
  # Cek jika style.css-bak sudah ada
  if [ ! -f "${STYLE_CSS_DEST}-bak" ]; then
    echo -e "${GREEN}File style.css sudah ada. Membuat backup dengan nama style.css-bak...${NC}"
    sudo mv "$STYLE_CSS_DEST" "${STYLE_CSS_DEST}-bak"
  else
    echo -e "${GREEN}File style.css-bak sudah ada, melewati backup...${NC}"
  fi
  echo -e "${GREEN}Mengganti style.css yang ada dengan yang baru...${NC}"
  sudo cp "$STYLE_CSS_SOURCE" "$STYLE_CSS_DEST"
else
  echo -e "${GREEN}File style.css tidak ditemukan di /etc/xdg/waybar. Menyalin file baru...${NC}"
  sudo cp "$STYLE_CSS_SOURCE" "$STYLE_CSS_DEST"
fi

# Periksa apakah direktori Downloads ada
if [ ! -d "$IMAGE_DIR" ]; then
  echo -e "${GREEN}Direktori Downloads tidak ditemukan. Membuat direktori...${NC}"
  mkdir -p "$IMAGE_DIR"
else
  echo -e "${GREEN}Direktori Downloads sudah ada. Melanjutkan proses...${NC}"
fi

# Menyalin wallpaper ke direktori Downloads
echo -e "${GREEN}Menyalin wallpaper-1.png ke direktori Downloads...${NC}"

# Periksa apakah file gambar sudah ada di direktori Downloads
if [ -f "$IMAGE_DEST" ]; then
  # Cek jika file backup dengan nama yang sama sudah ada
  if [ ! -f "$IMAGE_BACKUP" ]; then
    echo -e "${GREEN}File $IMAGE_FILE sudah ada di direktori Downloads. Membuat backup dengan nama ${IMAGE_FILE%.png}-bak.png...${NC}"
    mv "$IMAGE_DEST" "$IMAGE_BACKUP"
  else
    echo -e "${GREEN}File backup dengan nama ${IMAGE_FILE%.png}-bak.png sudah ada, melewati backup...${NC}"
  fi
  echo -e "${GREEN}Mengganti file $IMAGE_FILE yang ada dengan file baru...${NC}"
  cp "$IMAGE_SOURCE" "$IMAGE_DEST"
else
  echo -e "${GREEN}File $IMAGE_FILE tidak ditemukan di direktori Downloads. Menyalin file baru...${NC}"
  cp "$IMAGE_SOURCE" "$IMAGE_DEST"
fi

# Lanjutkan proses setup
echo -e "${GREEN}Proses wallpaper selesai!${NC}"
echo -e "${GREEN}Setup selesai!${NC}"
