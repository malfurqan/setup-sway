#!/usr/bin/env bash

## Author: Aditya Shakya (adi1090x)
## Github: @adi1090x
#
## Rofi: Hotspot Manager (Enable/Disable Hotspot)

dir="$HOME/.config/rofi/customs/type-1"
theme='style-4'

# Cek status koneksi Wi-Fi
wifi_status=$(nmcli -t -f WIFI g)

# Menentukan status hotspot
hotspot_status=$(nmcli device show wlan0 | grep -i "wifi" | awk '{print $2}')
if [[ "$hotspot_status" == "enabled" ]]; then
  hotspot_toggle="󰖪 Disable Hotspot"
else
  hotspot_toggle="󰖩 Enable Hotspot"
fi

# Pilihan untuk menampilkan daftar Wi-Fi dan mengatur hotspot
chosen_option=$(echo -e "$hotspot_toggle" | rofi -dmenu -theme ${dir}/${theme}.rasi -i -p "Hotspot Control: ")

if [ -z "$chosen_option" ]; then
  exit
elif [ "$chosen_option" == "󰖩 Enable Hotspot" ]; then
  # Enable hotspot
  ssid_name=$(rofi -dmenu -theme ${dir}/${theme}.rasi -p "Enter Hotspot SSID: ")
  password=$(rofi -dmenu -theme ${dir}/${theme}.rasi -p "Enter Hotspot Password: ")

  # Mengaktifkan hotspot
  nmcli dev wifi hotspot ifname wlan0 ssid "$ssid_name" password "$password" && notify-send "Hotspot Enabled" "Hotspot SSID: $ssid_name"
elif [ "$chosen_option" == "󰖪 Disable Hotspot" ]; then
  # Disable hotspot
  nmcli connection down id "Hotspot" && notify-send "Hotspot Disabled" "The hotspot has been turned off."
fi
