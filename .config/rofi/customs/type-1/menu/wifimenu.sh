#!/bin/bash

dir="$HOME/.config/rofi/customs/type-1"
theme='style-4'

# Fungsi untuk mendapatkan list Wi-Fi
get_wifi_list() {
  wifi_list=$(nmcli --fields "SECURITY,SSID" device wifi list | sed 1d | sed 's/  */ /g' | sed -E "s/WPA*.?\S/ /g" | sed "s/^--/ /g" | sed "s/  //g" | sed "/--/d")
  echo -e "  Refresh\n$wifi_list"
}

# Loop untuk mendukung refresh
while true; do
  chosen_network=$(get_wifi_list | uniq -u | rofi -dmenu -theme ${dir}/${theme}.rasi -i -selected-row 0 -p "Wi-Fi SSID: ")

  # Cek jika user menekan ESC atau enter kosong
  [ -z "$chosen_network" ] && exit

  # Jika user memilih opsi refresh
  if [[ "$chosen_network" == "  Refresh" ]]; then
    continue
  fi

  # Ambil SSID tanpa ikon di depan (3 karakter pertama)
  read -r chosen_id <<<"${chosen_network:3}"

  success_message="You are now connected to the Wi-Fi network \"$chosen_id\"."
  saved_connections=$(nmcli -g NAME connection)

  if [[ $(echo "$saved_connections" | grep -w "$chosen_id") = "$chosen_id" ]]; then
    nmcli connection up id "$chosen_id" | grep "successfully" && notify-send "Connection Established" "$success_message"
  else
    if [[ "$chosen_network" =~ "" ]]; then
      wifi_password=$(rofi -dmenu -theme ${dir}/${theme}.rasi -p "Password: ")
    fi
    nmcli device wifi connect "$chosen_id" password "$wifi_password" | grep "successfully" && notify-send "Connection Established" "$success_message"
  fi
  break
done
