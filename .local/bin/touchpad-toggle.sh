#!/bin/sh

# Set device to be toggled
HYPRLAND_DEVICE="elan1300:00-04f3:3087-touchpad"
HYPRLAND_VARIABLE="device[$HYPRLAND_DEVICE]:enabled"
TOUCHPAD_STATUS_FILE="/tmp/touchpad"

if [ -z "$XDG_RUNTIME_DIR" ]; then
  export XDG_RUNTIME_DIR=/run/user/$(id -u)
fi

if [ ! -f "$TOUCHPAD_STATUS_FILE" ]; then
  echo "enabled" > "$TOUCHPAD_STATUS_FILE"
  hyprctl keyword "$HYPRLAND_VARIABLE" true
  exit 0
fi

STATUS=$(cat "$TOUCHPAD_STATUS_FILE")

if [ "$STATUS" = "enabled" ]; then
  notify-send -u normal "Disabling Touchpad"
  hyprctl keyword "$HYPRLAND_VARIABLE" false
  echo "disabled" > "$TOUCHPAD_STATUS_FILE"
else
  notify-send -u normal "Enabling Touchpad"
  hyprctl keyword "$HYPRLAND_VARIABLE" true
  echo "enabled" > "$TOUCHPAD_STATUS_FILE"
fi
