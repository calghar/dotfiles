#!/usr/bin/env bash

# Get the primary network interface (usually en0 for Wi-Fi)
INTERFACE=$(route get default | grep interface | awk '{print $2}')

# Function to convert bytes to human readable format
convert_bytes() {
    local bytes=$1
    if [ $bytes -gt 1073741824 ]; then
        echo "$(echo "scale=1; $bytes/1073741824" | bc)GB"
    elif [ $bytes -gt 1048576 ]; then
        echo "$(echo "scale=1; $bytes/1048576" | bc)MB"
    elif [ $bytes -gt 1024 ]; then
        echo "$(echo "scale=0; $bytes/1024" | bc)KB"
    else
        echo "${bytes}B"
    fi
}

# Get network statistics
if [ -n "$INTERFACE" ]; then
    # Get current stats
    STATS=$(netstat -ibn | grep -E "^$INTERFACE" | head -n1)
    
    if [ -n "$STATS" ]; then
        RX_BYTES=$(echo $STATS | awk '{print $7}')
        TX_BYTES=$(echo $STATS | awk '{print $10}')
        
        # Store previous values (if they exist)
        PREV_RX_FILE="/tmp/sketchybar_rx_$INTERFACE"
        PREV_TX_FILE="/tmp/sketchybar_tx_$INTERFACE"
        
        if [ -f "$PREV_RX_FILE" ] && [ -f "$PREV_TX_FILE" ]; then
            PREV_RX=$(cat $PREV_RX_FILE)
            PREV_TX=$(cat $PREV_TX_FILE)
            
            # Calculate rates (bytes per second, update_freq is 2 seconds)
            RX_RATE=$(( (RX_BYTES - PREV_RX) / 2 ))
            TX_RATE=$(( (TX_BYTES - PREV_TX) / 2 ))
            
            # Convert to human readable
            RX_HUMAN=$(convert_bytes $RX_RATE)
            TX_HUMAN=$(convert_bytes $TX_RATE)
            
            # Create label with download and upload speeds
            LABEL="↓${RX_HUMAN}/s ↑${TX_HUMAN}/s"
        else
            LABEL="Calculating..."
        fi
        
        # Store current values for next iteration
        echo $RX_BYTES > $PREV_RX_FILE
        echo $TX_BYTES > $PREV_TX_FILE
    else
        LABEL="No Stats"
    fi
else
    LABEL="No Interface"
fi

# Update sketchybar
sketchybar --set "$NAME" icon="󰖟" label="$LABEL"