#!/usr/bin/env bash

source "$HOME/.config/sketchybar/variables.sh" # Loads all defined colors

sketchybar --add item spacer.1 left \
	--set spacer.1 background.drawing=off \
	label.drawing=off \
	icon.drawing=off \
	width=10

# Create spaces 1-10 to match aerospace configuration
for i in {1..10}; do
	sketchybar --add space space.$i left \
		--set space.$i associated_space=$i \
		label.drawing=off \
		icon.padding_left=8 \
		icon.padding_right=8 \
		background.padding_left=2 \
		background.padding_right=2 \
		background.corner_radius=6 \
		background.height=20 \
		script="$PLUGIN_DIR/space.sh" \
		click_script="aerospace workspace $i"
done

sketchybar --add item spacer.2 left \
	--set spacer.2 background.drawing=off \
	label.drawing=off \
	icon.drawing=off \
	width=5

sketchybar --add bracket spaces '/space.*/' \
	--set spaces background.border_width="$BORDER_WIDTH" \
	background.border_color="$RED" \
	background.corner_radius="$CORNER_RADIUS" \
	background.color="$BAR_COLOR" \
	background.height=26 \
	background.drawing=on

sketchybar --add item separator left \
	\
	icon.font="$FONT:Regular:16.0" \
	background.padding_left=26 \
	background.padding_right=15 \
	label.drawing=off \
	associated_display=active \
	icon.color="$YELLOW" # --set separator icon= \
