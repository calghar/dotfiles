#!/usr/bin/env bash

source "$HOME/.config/sketchybar/variables.sh"

# Extract workspace number from the item name (e.g., "space.1" -> "1")
WORKSPACE_ID=$(echo "$NAME" | cut -d'.' -f2)

# Check if this workspace actually exists
WORKSPACE_EXISTS=$(aerospace list-workspaces --all | grep "^$WORKSPACE_ID$")
if [ -z "$WORKSPACE_EXISTS" ]; then
    sketchybar --set $NAME drawing=off
    exit 0
else
    sketchybar --set $NAME drawing=on
fi

# Get current focused workspace from aerospace
FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused)

# Detect display configuration
DISPLAY_COUNT=$(aerospace list-monitors | wc -l)
BUILTIN_ACTIVE=$(aerospace list-monitors | grep -c "Built-in Retina Display")

# Get workspace name from array, or handle external workspace naming intelligently
if [ "$WORKSPACE_ID" -le 5 ]; then
    WORKSPACE_NAME="${SPACE_NAMES[$((WORKSPACE_ID-1))]}"
else
    # Only show external workspace naming when multiple displays are connected
    if [ "$DISPLAY_COUNT" -gt 1 ]; then
        if [ "$BUILTIN_ACTIVE" -gt 0 ]; then
            WORKSPACE_NAME="EXT$WORKSPACE_ID"
        else
            # If only external display, treat as main workspace
            WORKSPACE_NAME="MAIN$WORKSPACE_ID"
        fi
    else
        # Single display - hide extra workspaces completely
        sketchybar --set $NAME drawing=off
        exit 0
    fi
fi

if [ "$WORKSPACE_ID" = "$FOCUSED_WORKSPACE" ]; then
	# Get currently focused window's app name
	CURRENT_APP=$(aerospace list-windows --focused --format "%{app-name}" 2>/dev/null)
	
	# Truncate app name if longer than 12 characters
	if [[ ${#CURRENT_APP} -gt 12 ]]; then
		CURRENT_APP="${CURRENT_APP:0:9}..."
	fi
	
	# Show workspace as active with workspace name and app
	if [ -n "$CURRENT_APP" ]; then
		DISPLAY_LABEL="$WORKSPACE_NAME: $CURRENT_APP"
	else
		DISPLAY_LABEL="$WORKSPACE_NAME"
	fi
	
	sketchybar --set $NAME background.drawing=on \
					 background.color=$RED \
					 background.corner_radius=6 \
					 background.height=20 \
					 icon.color=$WHITE \
					 label.drawing=on \
					 label="$DISPLAY_LABEL" \
					 label.color=$WHITE \
					 label.max_chars=20
else
	# Check if workspace has any windows
	WORKSPACE_APPS=$(aerospace list-windows --workspace "$WORKSPACE_ID" --format "%{app-name}" 2>/dev/null | wc -l)
	
	if [ "$WORKSPACE_APPS" -gt 0 ]; then
		# Show workspace name if it has apps
		sketchybar --set $NAME background.drawing=off \
						 icon.color=$YELLOW \
						 label.drawing=on \
						 label="$WORKSPACE_NAME" \
						 label.color=$COMMENT
	else
		# Show only icon if empty
		sketchybar --set $NAME background.drawing=off \
						 icon.color=$COMMENT \
						 label.drawing=off \
						 label=""
	fi
fi