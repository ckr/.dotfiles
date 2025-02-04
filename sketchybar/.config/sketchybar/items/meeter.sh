#!/bin/sh

meeter=(
  alias.color=$WHITE
  background.color=$BACKGROUND_1
  background.border_color=$BACKGROUND_2
)

sketchybar --add alias "Meeter,Item-1" right \
           --set "Meeter,Item-1" "${meeter[@]}" 

