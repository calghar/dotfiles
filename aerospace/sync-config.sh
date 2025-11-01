#!/bin/bash
# AeroSpace Config Sync Script
# Merges base aerospace.toml with personal app assignments

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_CONFIG="$SCRIPT_DIR/aerospace.toml"
PERSONAL_CONFIG="$SCRIPT_DIR/aerospace-personal.toml"
TARGET_CONFIG="$HOME/.aerospace.toml"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo "🚀 AeroSpace Config Sync"
echo "━━━━━━━━━━━━━━━━━━━━━━"

# Check if base config exists
if [ ! -f "$BASE_CONFIG" ]; then
    echo -e "${RED}✗ Base config not found: $BASE_CONFIG${NC}"
    exit 1
fi

# Create personal config from example if it doesn't exist
if [ ! -f "$PERSONAL_CONFIG" ]; then
    echo -e "${YELLOW}⚠ Personal config not found${NC}"
    if [ -f "$SCRIPT_DIR/aerospace-personal.toml.example" ]; then
        echo "  Creating from example..."
        cp "$SCRIPT_DIR/aerospace-personal.toml.example" "$PERSONAL_CONFIG"
        echo -e "${GREEN}✓ Created $PERSONAL_CONFIG${NC}"
        echo -e "${YELLOW}  Please edit it to add your app assignments${NC}"
    else
        echo -e "${RED}✗ Example config not found${NC}"
        exit 1
    fi
fi

# Merge configs
echo "📝 Merging configurations..."

# Copy base config first
cp "$BASE_CONFIG" "$TARGET_CONFIG"

# Append personal config (skip the header comments)
if [ -f "$PERSONAL_CONFIG" ]; then
    echo "" >> "$TARGET_CONFIG"
    echo "# ═══════════════════════════════════════════════════════════════════" >> "$TARGET_CONFIG"
    echo "# Personal App Assignments (from aerospace-personal.toml)" >> "$TARGET_CONFIG"
    echo "# ═══════════════════════════════════════════════════════════════════" >> "$TARGET_CONFIG"

    # Append personal config, removing the default float rule from base
    sed -i.bak '/^# Default: All windows float unless explicitly assigned$/,/run = \[\x27layout floating\x27\]/d' "$TARGET_CONFIG"

    cat "$PERSONAL_CONFIG" >> "$TARGET_CONFIG"

    # Add the default float rule at the end
    echo "" >> "$TARGET_CONFIG"
    echo "# Default: All other windows float" >> "$TARGET_CONFIG"
    echo "[[on-window-detected]]" >> "$TARGET_CONFIG"
    echo "run = ['layout floating']" >> "$TARGET_CONFIG"

    rm -f "$TARGET_CONFIG.bak"
fi

echo -e "${GREEN}✓ Config synced to $TARGET_CONFIG${NC}"
echo ""
echo "To apply changes:"
echo "  1. Reload AeroSpace: aerospace reload-config"
echo "  2. Or press: Alt+Shift+; then Esc"
