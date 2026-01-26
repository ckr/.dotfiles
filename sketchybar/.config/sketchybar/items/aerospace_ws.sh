#!/usr/bin/env sh

aerospace_ws_logo=(
  update_freq=2
  background.padding_left=10
  icon="󱂬"
  icon.font.size=20
  script="$PLUGIN_DIR/aerospace_ws.sh"
)

sketchybar  --add   item aerospace_ws right \
            --set   aerospace_ws "${aerospace_ws_logo[@]}"\
            --subscribe aerospace_ws system_woke
