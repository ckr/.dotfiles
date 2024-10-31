#!/usr/bin/env sh

email_logo=(
  update_freq=60
  # background.padding_left=15
  icon.font.size=20
  script="$PLUGIN_DIR/email.sh"
)

sketchybar  --add   item email right \
            --set   email "${email_logo[@]}"\
            --subscribe email system_woke
