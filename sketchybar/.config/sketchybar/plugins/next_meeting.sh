#!/usr/bin/env bash
set -euo pipefail

source "colors.sh"

# SketchyBar provides $NAME (item name) automatically
ITEM="${NAME:-meetings}"

# Config: override via environment if needed
SHORTCUT_NAME="${SHORTCUT_NAME:-Get Next Meeting}"
# Nerd Font calendar glyph
ICON="${ICON:-󰃰}"

# Colors (ARGB)
COLOR_NORMAL="$LABEL_COLOR" #0xffc0caf5"  # blue-ish
COLOR_SOON="$ORANGE" #0xffe5c07b"    # amber (<= 15m)
COLOR_URGENT="$RED" #0xffe06c75"  # red   (<= 5m)
COLOR_ACTIVE="$GREEN" #0xff98c379"  # green
COLOR_ICON_DEFAULT="$ICON_COLOR" # "0xffc0caf5"

icon_only() {
  # Show only the icon (no label)
  sketchybar --set "$ITEM" \
    drawing=on \
    icon="$ICON" \
    icon.color="$COLOR_NORMAL" \
    label="" \
    label.drawing=off
  exit 0
}

# Ensure jq exists; if not, show icon only
if ! command -v jq >/dev/null 2>&1; then
  icon_only
fi

# Choose GNU date (gdate on macOS via coreutils)
date_cmd="date"
if ! date -d "1970-01-01T00:00:00Z" +%s >/dev/null 2>&1; then
  if command -v gdate >/dev/null 2>&1; then
    date_cmd="gdate"
  else
    icon_only
  fi
fi

# Get event from Shortcuts (expected JSON)
shortcut_out="$(shortcuts run "$SHORTCUT_NAME" 2>/dev/null || true)"
[ -z "$shortcut_out" ] && icon_only

# Validate JSON
if ! printf '%s' "$shortcut_out" | jq -e . >/dev/null 2>&1; then
  icon_only
fi

# Extract fields from single object or first element of array
read -r start_iso end_iso title <<<"$(printf '%s' "$shortcut_out" | jq -r '
  (if type=="array" then .[0] else . end) as $e
  | [($e.start // ""), ($e.end // ""), ($e.title // "")]
  | @tsv
')"

[ -z "$start_iso" ] && icon_only

# Parse timestamps
start_epoch="$($date_cmd -d "$start_iso" +%s 2>/dev/null || true)"
[ -z "${start_epoch:-}" ] && icon_only

end_epoch=""
if [ -n "$end_iso" ]; then
  end_epoch="$($date_cmd -d "$end_iso" +%s 2>/dev/null || true)"
fi

now_epoch="$($date_cmd +%s)"
today_local="$($date_cmd +%F)"
start_local="$($date_cmd -d "@$start_epoch" +%F)"
end_local=""
[ -n "$end_epoch" ] && end_local="$($date_cmd -d "@$end_epoch" +%F)"

# Determine ongoing state
ongoing=false
if [ -n "$end_epoch" ]; then
  if [ "$now_epoch" -ge "$start_epoch" ] && [ "$now_epoch" -lt "$end_epoch" ]; then
    if [ "$start_local" = "$today_local" ] || [ "$end_local" = "$today_local" ]; then
      ongoing=true
    fi
  fi
else
  if [ "$start_local" = "$today_local" ] && [ "$now_epoch" -ge "$start_epoch" ]; then
    ongoing=true
  fi
fi

# Format helper
fmt_diff() {
  local diff="$1"
  local hours=$(( diff / 3600 ))
  local mins=$(( (diff % 3600) / 60 ))
  local secs=$(( diff % 60 ))

  if (( hours > 0 )); then
    if (( mins > 0 )); then
      printf "in %dh%dm" "$hours" "$mins"
    else
      printf "in %dh" "$hours"
    fi
  elif (( mins > 0 )); then
    printf "in %dm" "$mins"
  else
    printf "in %ds" "$secs"
  fi
}

# Ongoing: show "Xm ago"
if $ongoing; then
  diff=$(( now_epoch - start_epoch ))
  label="$(fmt_diff "$diff") ago"
  sketchybar --set "$ITEM" \
    drawing=on \
    icon="$ICON" \
    icon.color="$COLOR_ACTIVE" \
    label="$label" \
    label.drawing=on \
    label.color="$COLOR_ACTIVE"
  exit 0
fi

# Upcoming later today: show "Xm" / "1h5m"
if [ "$start_local" = "$today_local" ] && [ "$start_epoch" -gt "$now_epoch" ]; then
  diff=$(( start_epoch - now_epoch ))
  label="$(fmt_diff "$diff")"

  color="$COLOR_NORMAL"
  if   (( diff <= 300 ));  then color="$COLOR_URGENT"
  elif (( diff <= 900 ));  then color="$COLOR_SOON"
  fi

  sketchybar --set "$ITEM" \
    drawing=on \
    icon="$ICON" \
    icon.color="$color" \
    label="$label" \
    label.drawing=on \
    label.color="$color"
  exit 0
fi

# No relevant meeting today (or past): show icon only
icon_only