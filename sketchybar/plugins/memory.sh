#!/usr/bin/env bash

# Get memory statistics using vm_stat
VM_STATS=$(vm_stat)

# Extract values (remove trailing periods and convert to integers)
PAGES_FREE=$(echo "$VM_STATS" | grep "Pages free" | awk '{print $3}' | sed 's/\.//')
PAGES_ACTIVE=$(echo "$VM_STATS" | grep "Pages active" | awk '{print $3}' | sed 's/\.//')
PAGES_INACTIVE=$(echo "$VM_STATS" | grep "Pages inactive" | awk '{print $3}' | sed 's/\.//')
PAGES_SPECULATIVE=$(echo "$VM_STATS" | grep "Pages speculative" | awk '{print $3}' | sed 's/\.//')
PAGES_WIRED=$(echo "$VM_STATS" | grep "Pages wired down" | awk '{print $4}' | sed 's/\.//')

# Get page size (usually 4096 bytes)
PAGE_SIZE=$(vm_stat | head -1 | grep -o '[0-9]\+')

# Calculate memory usage
USED_PAGES=$((PAGES_ACTIVE + PAGES_INACTIVE + PAGES_WIRED))
TOTAL_PAGES=$((PAGES_FREE + PAGES_ACTIVE + PAGES_INACTIVE + PAGES_SPECULATIVE + PAGES_WIRED))

# Calculate percentage
if [ $TOTAL_PAGES -gt 0 ]; then
    MEMORY_PERCENT=$((USED_PAGES * 100 / TOTAL_PAGES))
else
    MEMORY_PERCENT=0
fi

# Calculate memory in GB for display
USED_GB=$(echo "scale=1; $USED_PAGES * $PAGE_SIZE / 1024 / 1024 / 1024" | bc)
TOTAL_GB=$(echo "scale=1; $TOTAL_PAGES * $PAGE_SIZE / 1024 / 1024 / 1024" | bc)

# Create label - show only used memory
LABEL="${USED_GB}GB"

# Update sketchybar
sketchybar --set "$NAME" icon="󰘚" label="$LABEL"