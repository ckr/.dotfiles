#!/bin/sh

input_source=(
  icon.font="$FONT:Regular:20.0"
  script="$PLUGIN_DIR/get_input_source.sh"
  icon.color=$WHITE
  update_freq=1
  background.color=$BACKGROUND_1
  background.border_color=$BACKGROUND_2
  label.padding_left=10
  label.padding_right=10
)

sketchybar --add item input_source right \
           --set input_source "${input_source[@]}"

