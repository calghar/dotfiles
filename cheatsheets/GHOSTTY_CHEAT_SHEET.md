# Ghostty Cheat Sheet
> Terminal Configuration Reference

## Quick Start

| Command | Description |
|---------|-------------|
| `ghostty` | Start Ghostty terminal |
| `ghostty --config-file=path` | Start with custom config |
| `Cmd+f` | Toggle quick terminal overlay |

## Configuration Overview

**Theme:** Catppuccin Mocha  
**Font:** Maple Mono NF (22pt)  
**Background:** Translucent (85% opacity, 20px blur)  
**Shell Integration:** zsh with tmux workflow  

---

## Essential Key Bindings

### Window & Tab Management

| Key | Action |
|-----|--------|
| `Cmd+t` | New tmux window |
| `Cmd+w` | Close tmux pane |
| `Cmd+Shift+w` | Close Ghostty native pane |
| `Cmd+f` | Toggle quick terminal (center overlay) |

### Navigation - Tmux Integration

| Key | Action |
|-----|--------|
| `Alt+←/→/↑/↓` | Navigate tmux panes |
| `Alt+Tab` | Cycle through tmux panes |
| `Cmd+1-9` | Switch to tmux window number |
| `Cmd+[` | Previous tmux window |
| `Cmd+]` | Next tmux window |
| `Cmd+grave` | Show tmux window list |

### Navigation - Ghostty Native

| Key | Action |
|-----|--------|
| `Ctrl+Shift+←/→/↑/↓` | Navigate Ghostty panes |

### Window Operations

| Key | Action |
|-----|--------|
| `Cmd+\` | Split tmux pane horizontally |
| `Cmd+Shift+\` | Split tmux pane vertically |
| `Cmd+z` | Toggle tmux pane zoom |
| `Cmd+u` | Enter tmux copy mode |

---

## Quick Terminal Feature

**Shortcut:** `Cmd+f`

- **Position:** Center overlay
- **Auto-hide:** Enabled
- **Usage:** Quick commands without leaving current context
- Press `Cmd+f` again to hide

---

## Theme & Appearance

### Current Setup
```
Theme: catppuccin-mocha
Font: Maple Mono NF 
Background: #0f0f0f (85% opacity, 20px blur)
Cursor: Bar style (no blinking)
Window: Hidden titlebar
```

### Font Features
- **Primary:** Maple Mono NF for code
- **Chinese Support:** LXGW WenKai for CJK characters
- **Nerd Font Icons:** Complete icon set support

---

## Mouse Settings

| Feature | Status |
|---------|--------|
| **Hide while typing** | Enabled |
| **Copy on select** | Enabled |
| **Option as Alt** | Enabled (macOS) |

---

## Performance & Updates

| Setting | Value |
|---------|-------|
| **Scrollback** | 10,000 lines |
| **Term type** | xterm-256color |
| **Update channel** | tip (latest) |
| **Shell integration** | zsh |

---

## tmux Integration Workflow

### Daily Usage Pattern
```bash
# Start terminal with tmux profiles
ghostty                 # Auto-loads tmux with 4 profiles

# Quick navigation
Cmd+1                   # Dev profile
Cmd+2                   # Monitor profile  
Cmd+3                   # Terminal profile
Cmd+4                   # Logs profile

# Quick commands
Cmd+f                   # Overlay terminal for one-off commands
```

### Key Mapping Logic
All `Cmd+` shortcuts send tmux prefix (`Ctrl+b`) commands:
- `Cmd+t` → `Ctrl+b c` (new window)
- `Cmd+w` → `Ctrl+b x` (close pane)
- `Cmd+1` → `Ctrl+b 1` (window 1)

---

## Advanced Features

### Multi-Session Support
- Works seamlessly with tmux session management
- SessionX integration for fuzzy session switching
- Automatic session persistence and restoration

### Quick Terminal Use Cases
```bash
# Quick file operations
Cmd+f → ls -la → Cmd+f

# Quick git status
Cmd+f → git status → Cmd+f

# Quick calculations
Cmd+f → bc -l → Cmd+f
```

---

## Configuration Files

| File | Purpose |
|------|---------|
| `config` | Main configuration |
| `appearances.conf` | Theme and visual settings |
| `mappings.conf` | Custom key bindings |
| `shaders/` | Custom cursor effects |

---

## Pro Tips

> **TMUX FIRST**  
> • All shortcuts are designed around tmux workflow  
> • Use `Cmd+f` for quick tasks outside tmux context  
> • Native Ghostty panes are secondary to tmux panes

> **MUSCLE MEMORY**  
> • `Cmd+1-4` → Instant profile switching via tmux  
> • `Alt+arrows` → Fast pane navigation  
> • `Cmd+f` → Quick terminal overlay anywhere

> **PERFORMANCE**  
> • Translucent background with blur for aesthetics  
> • Font optimized for both coding and readability  
> • Shell integration provides enhanced features

> **WORKFLOW INTEGRATION**  
> • Designed to work with existing tmux setup  
> • Quick terminal complements tmux sessions  
> • All key bindings avoid conflicts with tmux/nvim

---

**Optimized for tmux-based development workflow with aesthetic transparency and performance**