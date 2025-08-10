#!/usr/bin/env bash

# Cache file to store weather data
CACHE_FILE="/tmp/sketchybar_weather_cache"
CACHE_EXPIRY=600  # 10 minutes

# Function to get weather icon based on condition
get_weather_icon() {
    local condition="$1"
    case "$condition" in
        *"Clear"*|*"Sunny"*)
            echo "󰖙"  # sun
            ;;
        *"Partly"*|*"Partially"*)
            echo "󰖕"  # sun behind cloud
            ;;
        *"Cloudy"*|*"Overcast"*)
            echo "󰖐"  # cloud
            ;;
        *"Rain"*|*"Drizzle"*)
            echo "󰖗"  # rain
            ;;
        *"Snow"*|*"Blizzard"*)
            echo "󰖘"  # snow
            ;;
        *"Thunder"*|*"Storm"*)
            echo "󰖓"  # lightning
            ;;
        *"Fog"*|*"Mist"*)
            echo "󰖑"  # fog
            ;;
        *)
            echo "󰖐"  # default cloud
            ;;
    esac
}

# Check if cache exists and is still fresh
if [[ -f "$CACHE_FILE" ]]; then
    CACHE_AGE=$(($(date +%s) - $(stat -f %m "$CACHE_FILE")))
    if [[ $CACHE_AGE -lt $CACHE_EXPIRY ]]; then
        CACHED_DATA=$(cat "$CACHE_FILE")
        if [[ -n "$CACHED_DATA" ]]; then
            echo "$CACHED_DATA"
            sketchybar --set "$NAME" label="$CACHED_DATA"
            exit 0
        fi
    fi
fi

# Fetch weather data
# Using wttr.in with format: temperature and condition
# %t = temperature, %C = condition
WEATHER_DATA=$(curl -s "wttr.in/?format=%t+%C" --connect-timeout 3 --max-time 5 2>/dev/null)

if [[ -n "$WEATHER_DATA" && "$WEATHER_DATA" != *"Unknown"* ]]; then
    # Extract temperature and condition
    TEMP=$(echo "$WEATHER_DATA" | awk '{print $1}')
    CONDITION=$(echo "$WEATHER_DATA" | cut -d' ' -f2-)
    
    # Get appropriate weather icon
    ICON=$(get_weather_icon "$CONDITION")
    
    # Format the display
    LABEL="$TEMP $CONDITION"
    
    # Cache the result
    echo "$LABEL" > "$CACHE_FILE"
    
    # Update sketchybar
    sketchybar --set "$NAME" icon="$ICON" label="$LABEL"
else
    # Fallback if weather fetch fails
    LABEL="Weather N/A"
    sketchybar --set "$NAME" icon="󰖐" label="$LABEL"
fi