#!/bin/bash
swaymsg workspace number $(($(swaymsg -t get_workspaces | jq -r ".[] | select(.focused==true).num") + 1))
