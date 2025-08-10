# Dotfiles

<div align="center">

![Zsh](https://img.shields.io/badge/Zsh-5.9-blue?style=for-the-badge&logo=gnu-bash&logoColor=white)
![Tmux](https://img.shields.io/badge/Tmux-3.4-green?style=for-the-badge&logo=tmux&logoColor=white)
![Neovim](https://img.shields.io/badge/Neovim-0.10.2-brightgreen?style=for-the-badge&logo=neovim&logoColor=white)
![AeroSpace](https://img.shields.io/badge/AeroSpace-0.14.2-orange?style=for-the-badge)

![Starship](https://img.shields.io/badge/Starship-1.20.1-purple?style=for-the-badge&logo=starship&logoColor=white)
![Yazi](https://img.shields.io/badge/Yazi-0.3.3-yellow?style=for-the-badge)
![Ghostty](https://img.shields.io/badge/Ghostty-24.12.1-red?style=for-the-badge)
![macOS](https://img.shields.io/badge/macOS-Sequoia-blue?style=for-the-badge&logo=apple&logoColor=white)

</div>

My personal macOS development setup. Built around [Zsh](https://zsh.sourceforge.io/), [Tmux](https://github.com/tmux/tmux), [Neovim](https://neovim.io/), and tiling window management.

## Quick Setup

```bash
git clone https://github.com/calghar/dotfiles.git ~/dotfiles
cd ~/dotfiles
./setup.sh
```

> **⚠️ Note**: On first setup, you may need to restart your terminal or run `source ~/.zshrc` to load the new shell configuration.

### Verify Installation

After setup, restart your terminal or run `source ~/.zshrc` to load the new shell configuration.

## What's Inside

### Shell & Terminal

- [Zsh](https://zsh.sourceforge.io/) with plugins and custom configuration
- [Starship](https://starship.rs/) prompt
- [Tmux](https://github.com/tmux/tmux) with plugin manager
- [Ghostty](https://ghostty.org/) terminal emulator
- [Atuin](https://github.com/atuinsh/atuin) shell history management

### Development

- [Neovim](https://neovim.io/) with [NvChad](https://nvchad.com/)
- [Neovide](https://neovide.dev/) GUI for Neovim
- [Yazi](https://yazi-rs.github.io/) file manager
- [Zoxide](https://github.com/ajeetdsouza/zoxide) smart cd
- [thefuck](https://github.com/nvbn/thefuck) command correction

### Window Management

- [AeroSpace](https://github.com/nikitabobko/AeroSpace) tiling WM
- [SketchyBar](https://github.com/FelixKratz/SketchyBar) status bar  
- [SKHD](https://github.com/koekeishiya/skhd) hotkeys

### System Tools

- [btop](https://github.com/aristocratos/btop) system monitor
- [fastfetch](https://github.com/fastfetch-cli/fastfetch) system info
- [cava](https://github.com/karlstav/cava) audio visualizer

### Documentation

- **Cheat sheets** - Quick reference guides for Neovim and Tmux

## Manual Setup

If the script doesn't work:

1. **Install Homebrew**:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

2. **Install dependencies**:

```bash
brew bundle install
```

3. **Link configs with GNU Stow**:

```bash
stow . --target="$HOME"
```

> **Note**: This setup uses [GNU Stow](https://www.gnu.org/software/stow/) for symlink management. Each tool's configuration in `~/dotfiles/toolname/` gets symlinked to the appropriate location in `~/.config/`.

4. **Change shell** (if needed):

```bash
chsh -s /bin/zsh
```

5. **Install tmux plugins**:
Start tmux and press `Ctrl+B + I` (if not done automatically)

## Directory Structure

```
.zshrc        # Main Zsh configuration file
aerospace/    # Window manager config (5 workspaces: Dev, Productivity, Communication, Business, Extended Comm)
atuin/        # Shell history management config
btop/         # System monitor config
cava/         # Audio visualizer config
cheatsheets/  # Quick reference guides (Neovim, Tmux)
fastfetch/    # System info config
ghostty/      # Terminal config (tmux-integrated workflow)
neovide/      # Neovim GUI config
nvim/         # Editor config
sketchybar/   # Status bar config (with JetBrainsMono Nerd Font)
skhd/         # Hotkeys config
starship/     # Prompt config
tmux/         # Multiplexer config (Ctrl+B prefix)
yazi/         # File manager config
zsh/          # Shell plugins (syntax highlighting, autosuggestions)
```

## Usage

### Workspace Management (AeroSpace)
- **Alt+1-5**: Switch to workspace 1-5
- **Alt+Shift+1-5**: Move window to workspace 1-5
- **Workspace 1**: Development (Ghostty, Arc, VSCode)
- **Workspace 2**: Productivity (Brave, Obsidian, Notion, Notes)  
- **Workspace 3**: Communication (Slack)
- **Workspace 4**: Business (Chrome, Outlook)
- **Workspace 5**: Extended Communication (WeChat, Lark, Discord)

### Terminal & Tmux
- **Tmux prefix**: `Ctrl+B`
- **Cmd+D**: Split tmux pane vertically (via Ghostty)
- **Cmd+\**: Split tmux pane horizontally (via Ghostty)
- **Alt+arrows**: Navigate between tmux panes (via Ghostty)
- **Cmd+W**: Close tmux pane (via Ghostty)
- **Cmd+Shift+W**: Close Ghostty native pane
- **Ctrl+Shift+arrows**: Navigate between Ghostty native panes

### General
- **File manager**: Type `yazi` in terminal
- **Smart cd**: `z <partial-path>` jumps to directories
- **System monitor**: `btop`
- **Audio visualizer**: `cava`

### SketchyBar Theme Switching
- **Switch themes**: `theme <theme-name>`
- **List all themes**: `theme`
- **Available themes**: catppuccin-mocha, dracula, nord, gruvbox-dark, tokyonight-night, tokyonight-day, one-dark, solarized-dark, material-ocean, rose-pine, github-dark
- **Examples**: `theme dracula`, `theme nord`, `theme catppuccin-mocha`

## Troubleshooting

### Tmux Plugins Not Loading
If your tmux theme/status bar isn't showing:
```bash
# Install TPM manually
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Reload tmux config
tmux source-file ~/.config/tmux/tmux.conf

# Install plugins
~/.tmux/plugins/tpm/scripts/install_plugins.sh
```

### Missing Calendar in Status Bar
Install icalBuddy if the calendar doesn't show:
```bash
brew install ical-buddy
```

### Zsh Configuration Not Loading
Restart your terminal or source the configuration:
```bash
source ~/.zshrc
```

### Permissions Issues with SketchyBar
Make sure SketchyBar plugins are executable:
```bash
chmod +x ~/.config/sketchybar/plugins/*
```

## 🙏 Acknowledgments

Huge thanks to all the amazing developers and maintainers who created these incredible tools:

- **[Zsh Community](https://zsh.sourceforge.io/)** - For the powerful shell experience
- **[Tmux Contributors](https://github.com/tmux/tmux)** - Terminal multiplexing magic
- **[Neovim Team](https://neovim.io/)** & **[NvChad](https://nvchad.com/)** - Modern vim experience
- **[Nikita Bobko](https://github.com/nikitabobko)** - AeroSpace tiling window manager
- **[Felix Kratz](https://github.com/FelixKratz)** - SketchyBar status bar
- **[Koekeishiya](https://github.com/koekeishiya)** - SKHD hotkey daemon
- **[Starship Team](https://starship.rs/)** - Cross-shell prompt perfection
- **[Yazi Team](https://yazi-rs.github.io/)** - Terminal file manager excellence
- **[All other contributors](https://github.com/)** - For making the terminal a beautiful place to work

