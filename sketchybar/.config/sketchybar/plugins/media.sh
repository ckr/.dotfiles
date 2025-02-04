#!/usr/bin/env sh

source "colors.sh"
source "icons.sh"

# Name of executable in $HOME/.bin (symlinked)
NPCLI="nowplaying-cli"

# Currently playing music info
TRACK="$($NPCLI get title)"
if [ "$TRACK" = "null" ]; then
  TRACK=""
fi
ARTIST="$($NPCLI get artist)"
if [ "$ARTIST" = "null" ]; then
  ARTIST=""
fi

if [ ! -z $TRACK ] || [ ! -z $ARTIST ]; then
  TITLE="$TRACK · $ARTIST"
fi

# Get the duration and elapsed time from the nowplaying-cli
# DURATION="$($NPCLI get Duration)"
# ELAPSED_TIME="$($NPCLI get ElapsedTime)"
PLAYBACK_RATE="$($NPCLI get PlaybackRate)"

# Convert the elapsed time to minutes and seconds
# ELAPSED_MINUTES=$(awk "BEGIN {printf \"%d\", $ELAPSED_TIME/60}")
# ELAPSED_SECONDS=$(awk "BEGIN {printf \"%d\", $ELAPSED_TIME%60}")

# Format the seconds to always be two digits
# printf -v ELAPSED_SECONDS "%02d" $ELAPSED_SECONDS

# Calculate the percentage of the song elapsed
# PERCENTAGE=$(bc -l <<< "$ELAPSED_TIME*100/$DURATION")
# PERCENTAGE=$(printf "%.0f" $PERCENTAGE) # Round to the nearest whole number

# Display the result in the requested format
# TIME="${ELAPSED_MINUTES}:${ELAPSED_SECONDS} ${PERCENTAGE}%"

# Set PLAYBACK_STATE based on the playback rate
if [ "$PLAYBACK_RATE" == "0" ]; then
    PLAYBACK_STATE=" $MEDIA_PLAY"
elif [ "$PLAYBACK_RATE" = "null" ]; then
    PLAYBACK_STATE=""
else
    PLAYBACK_STATE=" $MEDIA_PAUSE"
fi

sketchybar --set media label="$TITLE$PLAYBACK_STATE"

