#!/usr/bin/env bash
set -euo pipefail

source "colors.sh"

# SketchyBar provides $NAME (item name); fallback for manual runs
ITEM="${NAME:-aerospace_ws}"

# Appearance (override via env if desired)
ICON="${ICON:-󱂬}"
COLOR_LABEL="${LABEL_COLOR:-0xffc0caf5}"
COLOR_ICON="${ICON_COLOR:-0xffc0caf5}"

# Modes treated as "no special mode" (adjust to your setup)
DEFAULT_MODE_NAMES=("main" "")

trim() { awk '{$1=$1;print}' <<<"${1:-}"; }

# Get current workspace as a simple string
get_workspace() {
  local ws
  ws="$(aerospace list-workspaces --focused 2>/dev/null | head -n1 || true)"
  ws="$(trim "$ws")"
  printf '%s' "$ws"
}

# Get current mode, reduce to first character, wrap in [X]
get_mode_badge() {
  local mode raw first
  raw="$(aerospace list-modes --current 2>/dev/null | head -n1 || true)"
  mode="$(trim "$raw")"
  if [ -z "$mode" ]; then
    printf '%s' ""
    return 0
  fi

  # Hide badge for default/normal modes (customize as needed)
  local lowered; lowered="$(tr '[:upper:]' '[:lower:]' <<<"$mode")"
  for d in "${DEFAULT_MODE_NAMES[@]}"; do
    if [ "$lowered" = "$d" ]; then
      printf '%s' ""
      return 0
    fi
  done

  first="$(printf '%.1s' "$mode")"
  first="${first^^}"  # uppercase
  printf '[%s]' "$first"
}

# If aerospace is missing, show icon only
if ! command -v aerospace >/dev/null 2>&1; then
  sketchybar --set "$ITEM" drawing=on icon="$ICON" icon.color="$COLOR_ICON" label="" label.drawing=off
  exit 0
fi

ws="$(get_workspace)"
badge="$(get_mode_badge)"

label=""
if [ -n "$ws" ] && [ -n "$badge" ]; then
  label="${ws} ${badge}"
elif [ -n "$ws" ]; then
  label="${ws}"
elif [ -n "$badge" ]; then
  label="${badge}"
fi

if [ -n "$label" ]; then
  sketchybar --set "$ITEM" drawing=on icon="$ICON" icon.color="$COLOR_ICON" label="$label" label.color="$COLOR_LABEL" label.drawing=on
else
  # Nothing to show: icon only
  sketchybar --set "$ITEM" drawing=on icon="$ICON" icon.color="$COLOR_ICON" label="" label.drawing=off
fi