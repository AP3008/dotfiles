#!/bin/bash

sketchybar --add item media e \
           --set media label.color=$ACCENT_COLOR \
                       label.max_chars=20 \
                       icon.padding_left=0 \
                       scroll_texts=on \
                       icon="󰐊" \
                       icon.color=$ACCENT_COLOR \
                       background.drawing=off \
                       update_freq=1 \
                       script="$PLUGIN_DIR/media.sh" \
                       click_script="nowplaying-cli togglePlayPause" \
           --subscribe media media_change
