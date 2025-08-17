#!/usr/bin/env python3
import json
import subprocess

try:
    output = subprocess.check_output(["swaync-client", "-swj"]).decode("utf-8")
    data = json.loads(output)

    notifications = data.get("notifications", [])
    count = len(notifications)

    print(f"{count} 󰂚")
except Exception as e:
    print("󰂛")  # fallback icon kalau error
