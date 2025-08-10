#!/usr/bin/env bash

source "$HOME/.config/sketchybar/variables.sh"

case "$SENDER" in
"front_app_switched")
	# Check if we should show front_app or let workspace handle it
	FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused 2>/dev/null)
	WORKSPACE_HAS_APPS=$(aerospace list-windows --workspace focused --format "%{app-name}" 2>/dev/null | head -n1)
	
	# Only show front_app if workspace doesn't show app info or for fallback
	if [ -z "$WORKSPACE_HAS_APPS" ] || [ -z "$FOCUSED_WORKSPACE" ]; then
		# Truncate app name if too long
		APP_NAME="$INFO"
		if [[ ${#APP_NAME} -gt 15 ]]; then
			APP_NAME="${APP_NAME:0:12}..."
		fi
		
		sketchybar --set "$NAME" label="$APP_NAME" drawing=on
	else
		sketchybar --set "$NAME" drawing=off
	fi
	;;
esac
