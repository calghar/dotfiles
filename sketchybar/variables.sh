#!/usr/bin/env sh

# Color Palette
# Dracula Theme
BLACK=0xff282a36
WHITE=0xfff8f8f2
MAGENTA=0xffff79c6
BLUE=0xff8be9fd
CYAN=0xff8be9fd
GREEN=0xff50fa7b
YELLOW=0xfff1fa8c
ORANGE=0xffffb86c
RED=0xffff5555
BAR_COLOR=0xff1e1f29
COMMENT=0xff6272a4TRANSPARENT=0x00000000

# General bar colors
ICON_COLOR=$WHITE  # Color of all icons
LABEL_COLOR=$WHITE # Color of all labels

ITEM_DIR="$HOME/.config/sketchybar/items"
PLUGIN_DIR="$HOME/.config/sketchybar/plugins"

FONT="JetBrainsMono Nerd Font"

PADDINGS=3

POPUP_BORDER_WIDTH=2
POPUP_CORNER_RADIUS=11
POPUP_BACKGROUND_COLOR=$BLACK
POPUP_BORDER_COLOR=$COMMENT

CORNER_RADIUS=15
BORDER_WIDTH=2

SHADOW=on

SPACE_ICONS=("󰨞" "󰈹" "󰭹" "󰢮" "󰙯")
SPACE_NAMES=("DEV" "PROD" "COMM" "BIZ" "EXTRA")
