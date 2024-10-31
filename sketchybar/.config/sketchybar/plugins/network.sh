#!/usr/bin/env sh

source "colors.sh"
source "icons.sh"

IP_ADDRESS=$(scutil --nwi | grep address | sed 's/.*://' | tr -d ' ' | head -1)
IS_VPN=$(scutil --nwi | grep -m1 'utun' | awk '{ print $1 }')
IS_WIFI=$(scutil --nwi | grep -m1 'en0' | awk '{ print $1 }')

if [[ $IS_VPN != "" ]]; then
	COLOR=$GREEN
	ICON=$VPN
elif [[ $IP_ADDRESS != "" ]]; then
  if [[ $IS_WIFI != "" ]]; then
    COLOR=$BLUE
    ICON=$WIFI_CONNECTED
  else
    COLOR=$BLUE
    ICON=$ETH
  fi
else
	COLOR=$WHITE
	ICON=
fi

sketchybar --set $NAME icon=$ICON label="" icon.color=$COLOR 
