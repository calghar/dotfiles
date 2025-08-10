#!/usr/bin/env bash

# Tmux Profile Startup Script
# This script creates predefined profiles when tmux starts

# Check if tmux server is running and if profiles already exist
if tmux has-session -t dev 2>/dev/null; then
    echo "Profiles already exist. Attaching to dev session."
    tmux attach-session -t dev
    exit 0
fi

# Create profiles
echo "Creating tmux profiles..."

# Profile 1: Development
tmux new-session -d -s 'dev' -c "$HOME/dotfiles"
tmux split-window -h -t 'dev' -c "$HOME/dotfiles"
tmux split-window -v -t 'dev:0.1' -c "$HOME/dotfiles"
tmux select-pane -t 'dev:0.0'
tmux send-keys -t 'dev:0.0' 'nvim' Enter
tmux send-keys -t 'dev:0.1' 'git status' Enter
tmux send-keys -t 'dev:0.2' 'clear' Enter

# Profile 2: System Monitor
tmux new-session -d -s 'monitor' -c "$HOME"
tmux split-window -h -t 'monitor'
tmux split-window -v -t 'monitor:0.0'
tmux split-window -v -t 'monitor:0.2'
tmux send-keys -t 'monitor:0.0' 'htop' Enter
tmux send-keys -t 'monitor:0.1' 'btop' Enter
tmux send-keys -t 'monitor:0.2' 'iostat 2' Enter
tmux send-keys -t 'monitor:0.3' 'df -h' Enter

# Profile 3: Terminal
tmux new-session -d -s 'terminal' -c "$HOME"
tmux split-window -h -t 'terminal'
tmux send-keys -t 'terminal:0.0' 'clear' Enter
tmux send-keys -t 'terminal:0.1' 'clear' Enter

# Profile 4: Logs (macOS friendly)
tmux new-session -d -s 'logs' -c "$HOME"
tmux split-window -v -t 'logs'
tmux send-keys -t 'logs:0.0' 'log stream --level debug --predicate "subsystem == \"com.apple.console\"" 2>/dev/null || echo "Console logs not available"' Enter
tmux send-keys -t 'logs:0.1' 'clear && echo "Logs session ready - try: log show --last 1h"' Enter

# Attach to the development session
echo "Profiles created. Attaching to dev session."
tmux attach-session -t 'dev'