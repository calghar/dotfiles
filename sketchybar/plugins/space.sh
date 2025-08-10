#!/usr/bin/env bash

source "$HOME/.config/sketchybar/variables.sh" # Loads all defined colors

SPACE_CLICK_SCRIPT="aerospace workspace $SID"

# Always show all spaces, highlight only the active one
if [ "$SELECTED" = "true" ]; then
	sketchybar --animate tanh 5 --set "$NAME" \
		icon.color="$RED" \
		background.color="$RED" \
		background.border_color="$RED" \
		background.drawing=on \
		icon="${SPACE_ICONS[$SID - 1]}" \
		click_script="$SPACE_CLICK_SCRIPT"
else
	sketchybar --animate tanh 5 --set "$NAME" \
		icon.color="$COMMENT" \
		background.color="$TRANSPARENT" \
		background.border_color="$COMMENT" \
		background.drawing=off \
		icon="${SPACE_ICONS[$SID - 1]}" \
		click_script="$SPACE_CLICK_SCRIPT"
fi
