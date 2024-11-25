#!/usr/bin/env sh

slack_logo=(
  update_freq=60
  background.padding_left=5
  icon.font.size=20
  script="$PLUGIN_DIR/slack.sh"
)

sketchybar  --add   item slack right \
            --set   slack "${slack_logo[@]}"\
            --subscribe slack system_woke
