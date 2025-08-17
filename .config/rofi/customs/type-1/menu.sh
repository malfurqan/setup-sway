dir="$HOME/.config/rofi/customs/type-1"
theme='style-4'

source ~/.config/rofi/customs/type-1/menu/airplane-mode.sh
source ~/.config/rofi/customs/type-1/menu/nightmode.sh

wifi_menu="󰖩  Wi-Fi"
bluetooth_menu="󰂯 Bluetooth"
# Cek apakah gammastep sedang berjalan

# Gabungkan menu
choosen_menu=$(echo -e "$toggle_plane\n$wifi_menu\n$nightmode_menu\n$bluetooth_menu" | uniq -u | rofi -dmenu -theme ${dir}/${theme}.rasi -i -selected-row 0 -p "Menu Search: ")

if [ "$choosen_menu" = "" ]; then
  exit
elif [ "$choosen_menu" = "󰀞 Turn Off Airplane Mode" ]; then
  nmcli radio wifi on
elif [ "$choosen_menu" = "󰀝 Turn On Airplane Mode" ]; then
  nmcli radio wifi off
elif [ "$choosen_menu" = "󰖩  Wi-Fi" ]; then
  ~/.config/rofi/customs/type-1/menu/wifimenu.sh
elif [ "$choosen_menu" = "󰛓 Turn On Night Mode" ]; then
  gammastep -O 4500
elif [ "$choosen_menu" = "󰛓 Turn Off Night Mode" ]; then
  pkill gammastep
elif [ "$choosen_menu" = "󰂯 Bluetooth" ]; then
  blueman-manager
fi
