#!/bin/bash
current=$(swaymsg -t get_workspaces | jq -r ".[] | select(.focused==true).num")
if [ -z "$current" ]; then current=1; fi
if [ "$current" -gt 1 ]; then
  prev=$((current - 1))
  swaymsg "workspace number $prev"
fi
