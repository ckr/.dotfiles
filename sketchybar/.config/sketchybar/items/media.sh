#!/usr/bin/env sh

music=(
  icon=󰎆
  icon.color=$GREY
  icon.font="$FONT:Regular:14.0"
  icon.font.size=20
  label="."
  script="$PLUGIN_DIR/media.sh"
  click_script="nowplaying-cli togglePlayPause"
  background.drawing=on
  background.color=$BACKGROUND_1
  background.border_color=$BACKGROUND_2
  # background.corner_radius=5
  background.padding_left=5
  icon.padding_left=15
  icon.padding_right=5
  label.drawing=on
  label.padding_left=0
  label.padding_right=15
  label.font="$FONT:Regular:14.0"
  update_freq=3
)

### MUSIC ###
sketchybar --add item media right \
           --set media "${music[@]}" \
           --subscribe media media_change
