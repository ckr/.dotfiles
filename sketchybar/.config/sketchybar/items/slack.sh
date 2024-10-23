#!/usr/bin/env sh

slack_logo=(
  update_freq=180
  # background.padding_left=15
  icon.font.size=20
  script="$PLUGIN_DIR/slack.sh"
)

sketchybar  --add   item slack right \
            --set   slack "${slack_logo[@]}"\
            --subscribe slack system_woke
