# TMUX Cheat Sheet
> Configuration Reference

## Quick Start

| Command | Description |
|---------|-------------|
| `tmux` | Start tmux with all profiles |
| `tmux ls` | List all sessions |
| `tmux attach -t <session>` | Attach to specific session |
| `tmux kill-session -t <session>` | Kill session |

## Pre-configured Profiles
*Auto-launched when tmux starts*

| Profile | Shortcut | Layout |
|---------|----------|--------|
| **dev** | `<prefix> 1` | nvim \| git status \| terminal |
| **monitor** | `<prefix> 2` | htop \| btop \| iostat \| disk usage |
| **terminal** | `<prefix> 3` | dual general terminals |
| **logs** | `<prefix> 4` | system logs \| log terminal |

---

## Essential Key Bindings
> **Prefix:** `Ctrl+b` (then press the key below)

### Sessions

| Key | Action |
|-----|--------|
| `d` | Detach session (keeps running) |
| `s` | List and switch sessions |
| `$` | Rename current session |

### Windows (Tabs)

| Key | Action |
|-----|--------|
| `c` | Create new window |
| `n` / `p` | Next / Previous window |
| `w` | List all windows |
| `,` | Rename window |
| `&` | Kill window |
| `0-9` | Switch to window number |

### Panes (Splits)

| Key | Action |
|-----|--------|
| `%` | Split horizontally |
| `"` | Split vertically |
| `x` | Close pane |
| `z` | Toggle pane zoom |
| `{` / `}` | Swap pane left/right |

#### Vi-Style Navigation
| Key | Action |
|-----|--------|
| `h` / `j` / `k` / `l` | Navigate panes |

### Copy Mode (Vi-Style)

| Key | Action |
|-----|--------|
| `[` | Enter copy mode |
| `Space` | Start selection |
| `Enter` | Copy selection |
| `]` | Paste |

### Configuration

| Key | Action |
|-----|--------|
| `r` | Reload tmux config |

---

## Plugin Features

### SessionX
**Shortcut:** `<prefix> o`
- Fuzzy session finder
- Create sessions from directories  
- Zoxide integration for smart switching

### Floax
**Shortcut:** `<prefix> p`
- Floating terminal overlay (80% × 80%)
- Quick access from anywhere

### Session Persistence
- **Auto-saves** every 15 minutes
- **Auto-restores** on tmux restart
- **Manual save:** `<prefix> Ctrl+s`
- **Manual restore:** `<prefix> Ctrl+r`

### Enhanced Copy/Paste (Yank)
- System clipboard integration
- Copy with `y` in copy mode
- Paste from system clipboard

---

## Status Bar
```
session-name  ~/current/dir  meetings  15:30
```

---

## Daily Workflow

```bash
# Morning Setup
tmux                    # Auto-loads all 4 profiles

# Development Work
<prefix> 1             # Switch to dev profile
<prefix> o             # SessionX fuzzy finder for other sessions

# System Monitoring
<prefix> 2             # Check system health

# Quick Tasks
<prefix> p             # Floating terminal overlay

# End of Day
<prefix> d             # Detach (auto-saved)
```

---

## Advanced Commands

### Session Management
```bash
# Create named session
tmux new-session -s myproject

# Attach to specific profile
tmux attach -t dev
tmux attach -t monitor  
tmux attach -t terminal
tmux attach -t logs

# Kill specific session
tmux kill-session -t myproject

# Rename session (from within tmux)
tmux rename-session newname
```

### Window & Pane Operations
```bash
# Create window with specific name
<prefix> c
<prefix> , # then type name

# Split panes
<prefix> %    # vertical split
<prefix> "    # horizontal split

# Resize panes
<prefix> :resize-pane -U 5    # up 5 lines
<prefix> :resize-pane -D 5    # down 5 lines  
<prefix> :resize-pane -L 5    # left 5 columns
<prefix> :resize-pane -R 5    # right 5 columns
```

---

## Pro Tips

> **DETACH vs KILL**  
> • **Detach** (`<prefix> d`) → Session runs in background  
> • **Kill** (`<prefix> x/&`) → Permanently closes pane/window

> **MUSCLE MEMORY**  
> • `<prefix> 1-4` → Instant profile switching  
> • `<prefix> o` → Session fuzzy finder  
> • `<prefix> p` → Floating terminal anywhere  
> • `<prefix> r` → Reload config instantly

> **POWER MOVES**  
> • Use SessionX (`<prefix> o`) for project switching  
> • Leverage Floax (`<prefix> p`) for quick commands  
> • Sessions auto-save every 15 minutes

---

**Includes automatic session persistence - work is always saved and restored**