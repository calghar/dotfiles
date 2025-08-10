#!/usr/bin/env bash

THEMES_DIR="$HOME/.config/sketchybar/themes"
VARIABLES_FILE="$HOME/.config/sketchybar/variables.sh"

# Available themes
declare -A THEMES=(
    ["tokyonight-night"]="TokyoNight Night"
    ["tokyonight-day"]="TokyoNight Day" 
    ["catppuccin-mocha"]="Catppuccin Mocha"
    ["nord"]="Nord"
    ["gruvbox-dark"]="Gruvbox Dark"
    ["dracula"]="Dracula"
    ["one-dark"]="One Dark"
    ["solarized-dark"]="Solarized Dark"
    ["material-ocean"]="Material Ocean"
    ["rose-pine"]="Rosé Pine"
    ["github-dark"]="GitHub Dark"
)

show_usage() {
    echo "Usage: $0 [theme_name]"
    echo ""
    echo "Available themes:"
    for key in "${!THEMES[@]}"; do
        echo "  $key - ${THEMES[$key]}"
    done
    echo ""
    echo "Example: $0 catppuccin-mocha"
}

switch_theme() {
    local theme=$1
    
    # Create backup first
    cp "$VARIABLES_FILE" "$VARIABLES_FILE.bak"
    
    case $theme in
        "tokyonight-night")
            # Replace color section with TokyoNight Night
            sed -i '' '/^# Color Palette/,/^COMMENT=.*$/c\
# Color Palette\
# Tokyonight Night\
BLACK=0xff24283b\
WHITE=0xffa9b1d6\
MAGENTA=0xffbb9af7\
BLUE=0xff7aa2f7\
CYAN=0xff7dcfff\
GREEN=0xff9ece6a\
YELLOW=0xffe0af68\
ORANGE=0xffff9e64\
RED=0xfff7768e\
BAR_COLOR=0xff1a1b26\
COMMENT=0xff565f89' "$VARIABLES_FILE"
            echo "Switched to TokyoNight Night theme"
            ;;
        "tokyonight-day")
            # Replace color section with TokyoNight Day
            sed -i '' '/^# Color Palette/,/^COMMENT=.*$/c\
# Color Palette\
# Tokyonight Day\
BLACK=0xffe9e9ed\
WHITE=0xff3760bf\
MAGENTA=0xff9854f1\
BLUE=0xff2e7de9\
CYAN=0xff007197\
GREEN=0xff587539\
YELLOW=0xff8c6c3e\
ORANGE=0xffb15c00\
RED=0xfff52a65\
BAR_COLOR=0xffe1e2e7\
COMMENT=0xff565f89' "$VARIABLES_FILE"
            echo "Switched to TokyoNight Day theme"
            ;;
        "catppuccin-mocha")
            # Replace color section with Catppuccin Mocha
            sed -i '' '/^# Color Palette/,/^COMMENT=.*$/c\
# Color Palette\
# Catppuccin Mocha Theme\
BLACK=0xff1e1e2e\
WHITE=0xffcdd6f4\
MAGENTA=0xffcba6f7\
BLUE=0xff89b4fa\
CYAN=0xff94e2d5\
GREEN=0xffa6e3a1\
YELLOW=0xfff9e2af\
ORANGE=0xfffab387\
RED=0xfff38ba8\
BAR_COLOR=0xff11111b\
COMMENT=0xff585b70' "$VARIABLES_FILE"
            echo "Switched to Catppuccin Mocha theme"
            ;;
        "nord")
            # Replace color section with Nord
            sed -i '' '/^# Color Palette/,/^COMMENT=.*$/c\
# Color Palette\
# Nord Theme\
BLACK=0xff2e3440\
WHITE=0xffeceff4\
MAGENTA=0xffb48ead\
BLUE=0xff81a1c1\
CYAN=0xff88c0d0\
GREEN=0xffa3be8c\
YELLOW=0xffebcb8b\
ORANGE=0xffd08770\
RED=0xffbf616a\
BAR_COLOR=0xff3b4252\
COMMENT=0xff4c566a' "$VARIABLES_FILE"
            echo "Switched to Nord theme"
            ;;
        "gruvbox-dark")
            # Replace color section with Gruvbox Dark
            sed -i '' '/^# Color Palette/,/^COMMENT=.*$/c\
# Color Palette\
# Gruvbox Dark Theme\
BLACK=0xff282828\
WHITE=0xffebdbb2\
MAGENTA=0xffd3869b\
BLUE=0xff83a598\
CYAN=0xff8ec07c\
GREEN=0xffb8bb26\
YELLOW=0xfffabd2f\
ORANGE=0xffff9664\
RED=0xfffb4934\
BAR_COLOR=0xff1d2021\
COMMENT=0xff504945' "$VARIABLES_FILE"
            echo "Switched to Gruvbox Dark theme"
            ;;
        "dracula")
            # Replace color section with Dracula
            sed -i '' '/^# Color Palette/,/^COMMENT=.*$/c\
# Color Palette\
# Dracula Theme\
BLACK=0xff282a36\
WHITE=0xfff8f8f2\
MAGENTA=0xffff79c6\
BLUE=0xff8be9fd\
CYAN=0xff8be9fd\
GREEN=0xff50fa7b\
YELLOW=0xfff1fa8c\
ORANGE=0xffffb86c\
RED=0xffff5555\
BAR_COLOR=0xff1e1f29\
COMMENT=0xff6272a4' "$VARIABLES_FILE"
            echo "Switched to Dracula theme"
            ;;
        "one-dark")
            # Replace color section with One Dark
            sed -i '' '/^# Color Palette/,/^COMMENT=.*$/c\
# Color Palette\
# One Dark Theme\
BLACK=0xff282c34\
WHITE=0xffabb2bf\
MAGENTA=0xffc678dd\
BLUE=0xff61afef\
CYAN=0xff56b6c2\
GREEN=0xff98c379\
YELLOW=0xffe5c07b\
ORANGE=0xffd19a66\
RED=0xffe06c75\
BAR_COLOR=0xff21252b\
COMMENT=0xff5c6370' "$VARIABLES_FILE"
            echo "Switched to One Dark theme"
            ;;
        "solarized-dark")
            # Replace color section with Solarized Dark
            sed -i '' '/^# Color Palette/,/^COMMENT=.*$/c\
# Color Palette\
# Solarized Dark Theme\
BLACK=0xff002b36\
WHITE=0xff839496\
MAGENTA=0xffd33682\
BLUE=0xff268bd2\
CYAN=0xff2aa198\
GREEN=0xff859900\
YELLOW=0xffb58900\
ORANGE=0xffcb4b16\
RED=0xffdc322f\
BAR_COLOR=0xff073642\
COMMENT=0xff586e75' "$VARIABLES_FILE"
            echo "Switched to Solarized Dark theme"
            ;;
        "material-ocean")
            # Replace color section with Material Ocean
            sed -i '' '/^# Color Palette/,/^COMMENT=.*$/c\
# Color Palette\
# Material Ocean Theme\
BLACK=0xff0f111a\
WHITE=0xff8f93a2\
MAGENTA=0xffc792ea\
BLUE=0xff82aaff\
CYAN=0xff89ddff\
GREEN=0xffc3e88d\
YELLOW=0xffffcb6b\
ORANGE=0xfff78c6c\
RED=0xffff5370\
BAR_COLOR=0xff0a0e14\
COMMENT=0xff4a5568' "$VARIABLES_FILE"
            echo "Switched to Material Ocean theme"
            ;;
        "rose-pine")
            # Replace color section with Rosé Pine
            sed -i '' '/^# Color Palette/,/^COMMENT=.*$/c\
# Color Palette\
# Rosé Pine Theme\
BLACK=0xff191724\
WHITE=0xffe0def4\
MAGENTA=0xffc4a7e7\
BLUE=0xff9ccfd8\
CYAN=0xff9ccfd8\
GREEN=0xff31748f\
YELLOW=0xfff6c177\
ORANGE=0xffebbcba\
RED=0xffeb6f92\
BAR_COLOR=0xff1f1d2e\
COMMENT=0xff6e6a86' "$VARIABLES_FILE"
            echo "Switched to Rosé Pine theme"
            ;;
        "github-dark")
            # Replace color section with GitHub Dark
            sed -i '' '/^# Color Palette/,/^COMMENT=.*$/c\
# Color Palette\
# GitHub Dark Theme\
BLACK=0xff0d1117\
WHITE=0xfff0f6fc\
MAGENTA=0xffd2a8ff\
BLUE=0xff79c0ff\
CYAN=0xff56d4dd\
GREEN=0xff7ee787\
YELLOW=0xffe3b341\
ORANGE=0xffffab70\
RED=0xffff7b72\
BAR_COLOR=0xff010409\
COMMENT=0xff8b949e' "$VARIABLES_FILE"
            echo "Switched to GitHub Dark theme"
            ;;
        *)
            echo "Error: Unknown theme '$theme'"
            show_usage
            exit 1
            ;;
    esac
    
    # Reload SketchyBar
    sketchybar --reload
    echo "SketchyBar reloaded with new theme!"
}

# Main script
if [[ $# -eq 0 ]]; then
    show_usage
    exit 1
fi

if [[ ! -f "$VARIABLES_FILE" ]]; then
    echo "Error: SketchyBar variables file not found: $VARIABLES_FILE"
    exit 1
fi

switch_theme "$1"