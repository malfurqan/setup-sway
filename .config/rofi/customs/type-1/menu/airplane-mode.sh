#!/usr/bin/env bash

connected=$(nmcli -fields WIFI g)
if [[ "$connected" =~ "disabled" ]]; then
  toggle_plane="󰀞 Turn Off Airplane Mode"
elif [[ "$connected" =~ "enabled" ]]; then
  toggle_plane="󰀝 Turn On Airplane Mode"
fi
