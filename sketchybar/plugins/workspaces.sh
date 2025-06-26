#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh
export NERD_FONT="SFMono Nerd Font"

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set $NAME background.drawing=off label.padding_left=10 \
        label.padding_right=10 icon.padding_left=0 \
        icon.padding_right=0 \
        label.font="$NERD_FONT:Bold:14.0" \
        label.color=0xffffffff
else
    sketchybar --set $NAME background.drawing=off label.padding_left=10 \
        label.padding_right=10 icon.padding_left=0 \
        icon.padding_right=0 \
        label.font="$NERD_FONT:Regular:14.0" \
        label.color=0x64ffffff
fi
