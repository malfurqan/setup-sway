#!/usr/bin/env bash

## Author : Aditya Shakya (adi1090x)
## Github : @adi1090x
#
## Rofi   : Launcher (Modi Drun, Run, File Browser, Window)
#
## Available Styles
#
## style-1     style-2     style-3     style-4     style-5
## style-6     style-7     style-8     style-9     style-10
## style-11    style-12    style-13    style-14    style-15

dir="$HOME/.config/rofi/customs/type-1"
theme='style-4'

# Get a list of available wifi connections and morph it into a nice-looking list
wifi_list=$(nmcli --fields "SECURITY,SSID" device wifi list | sed 1d | sed 's/  */ /g' | sed -E "s/WPA*.?\S/ /g" | sed "s/^--/ /g" | sed "s/  //g" | sed "/--/d")

# Use rofi to select wifi network
chosen_network=$(echo -e "$wifi_list" | uniq -u | rofi -dmenu -theme ${dir}/${theme}.rasi -i -selected-row 1 -p "Wi-Fi SSID: ")
# Get name of connection
read -r chosen_id <<<"${chosen_network:3}"

if [ "$chosen_network" = "" ]; then
  exit
else
  # Message to show when connection is activated successfully
  success_message="You are now connected to the Wi-Fi network \"$chosen_id\"."
  # Get saved connections
  saved_connections=$(nmcli -g NAME connection)
  if [[ $(echo "$saved_connections" | grep -w "$chosen_id") = "$chosen_id" ]]; then
    nmcli connection up id "$chosen_id" | grep "successfully" && notify-send "Connection Established" "$success_message"
  else
    if [[ "$chosen_network" =~ "" ]]; then
      wifi_password=$(rofi -dmenu -theme ${dir}/${theme}.rasi -p "Password: ")
    fi
    nmcli device wifi connect "$chosen_id" password "$wifi_password" | grep "successfully" && notify-send "Connection Established" "$success_message"
  fi
fi
