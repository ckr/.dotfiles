#!/usr/bin/env sh

meetings_logo=(
  update_freq=30
  background.padding_left=10
  icon="󰃰"
  icon.font.size=20
  script="$PLUGIN_DIR/next_meeting.sh"
)

sketchybar  --add   item meetings right \
            --set   meetings "${meetings_logo[@]}"\
            --subscribe meetings system_woke
