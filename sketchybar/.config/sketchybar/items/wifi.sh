#!/usr/bin/env sh

# sketchybar --add alias "Control Centre,WiFi" right \
           # --set "Control Centre,WiFi" alias.color=$PUREWHITE

ip_address_info=(
  script="$PLUGIN_DIR/network.sh"
  update_freq=30
  icon.font.size=20
)

sketchybar --add item ip_address right \
           --set ip_address "${ip_address_info[@]}" \
           --subscribe ip_address wifi_change
