# Dotfiles

<div align="center">

![macOS](https://img.shields.io/badge/macOS-Sequoia-blue?style=for-the-badge&logo=apple&logoColor=white)
![Neovim](https://img.shields.io/badge/Neovim-0.12-brightgreen?style=for-the-badge&logo=neovim&logoColor=white)
![Ghostty](https://img.shields.io/badge/Ghostty-1.1-red?style=for-the-badge)
![AeroSpace](https://img.shields.io/badge/AeroSpace-0.20-orange?style=for-the-badge)
![Tmux](https://img.shields.io/badge/Tmux-3.6-green?style=for-the-badge&logo=tmux&logoColor=white)

</div>

macOS dev environment built around **Zsh**, **Tmux**, **Neovim** (NvChad), and **AeroSpace** tiling WM.

## Setup

```bash
git clone https://github.com/calghar/dotfiles.git ~/dotfiles
cd ~/dotfiles && ./setup.sh
```

Restart your terminal after setup to load the new configuration.

<details>
<summary><b>Manual setup</b></summary>

```bash
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install dependencies
brew bundle install

# Symlink configs (GNU Stow)
stow . --target="$HOME"

# Install tmux plugins: start tmux, then Ctrl+B + I
```

</details>

## What's Inside

| Category | Tools |
| --- | --- |
| **Shell** | [Zsh](https://zsh.sourceforge.io/) + [Starship](https://starship.rs/) prompt, [Atuin](https://atuin.sh/) history, [fzf](https://github.com/junegunn/fzf), [zoxide](https://github.com/ajeetdsouza/zoxide) |
| **Terminal** | [Ghostty](https://ghostty.org/) + [Tmux](https://github.com/tmux/tmux) (Catppuccin theme) |
| **Editor** | [Neovim](https://neovim.io/) ([NvChad](https://nvchad.com/)) + [Neovide](https://neovide.dev/) GUI |
| **Window Mgmt** | [AeroSpace](https://github.com/nikitabobko/AeroSpace) tiling WM + [SketchyBar](https://github.com/FelixKratz/SketchyBar) status bar |
| **File Mgmt** | [Yazi](https://yazi-rs.github.io/) file manager, [eza](https://github.com/eza-community/eza), [bat](https://github.com/sharkdp/bat) |
| **System** | [btop](https://github.com/aristocratos/btop), [fastfetch](https://github.com/fastfetch-cli/fastfetch), [cava](https://github.com/karlstav/cava) visualizer |

## Directory Structure

```text
.zshrc              # Shell configuration
aerospace/          # Tiling WM (base + personal config merge)
atuin/              # Shell history
btop/               # System monitor
cava/               # Audio visualizer + shaders
ghostty/            # Terminal (config, mappings, appearances, shaders)
nvim/               # Editor (NvChad-based)
sketchybar/         # Status bar (items, plugins, themes)
starship/           # Prompt theme (Catppuccin Mocha)
tmux/               # Multiplexer + plugins
yazi/               # File manager
zsh/                # Plugins (syntax highlighting, autosuggestions)
cheatsheets/        # Quick reference (Neovim, Tmux, Ghostty)
```

## Key Bindings

### AeroSpace (Tiling WM)

| Binding | Action |
| --- | --- |
| `Alt+1-5` | Switch workspace |
| `Alt+Shift+1-5` | Move window to workspace (follow) |
| `Ctrl+Alt+1-5` | Move window to workspace (stay) |
| `Hyper+H/J/K/L` | Focus left/down/up/right |
| `Alt+Shift+H/J/K/L` | Move window |
| `Alt+Space` | Toggle floating/tiling |
| `Alt+Tab` | Previous workspace |
| `Ctrl+Shift+Cmd+Alt+Enter` | Fullscreen |

### Ghostty + Tmux

| Binding | Action |
| --- | --- |
| `Cmd+T` | New tmux window |
| `Cmd+W` | Close tmux pane |
| `Cmd+1-9` | Switch tmux window |
| `Cmd+\` | Split horizontal |
| `Cmd+Shift+\` | Split vertical |
| `Alt+Arrows` | Navigate tmux panes |
| `Cmd+Z` | Zoom pane |
| `Cmd+F` | Quick terminal |

### AeroSpace Personal Config

App-to-workspace assignments are stored in `aerospace-personal.toml` (git-ignored). Copy the example to get started:

```bash
cp aerospace/aerospace-personal.toml.example aerospace/aerospace-personal.toml
# Edit with your apps, then merge:
./aerospace/sync-config.sh
```

### SketchyBar Themes

```bash
theme                    # List available themes
theme catppuccin-mocha   # Switch theme
theme dracula            # Available: catppuccin-mocha, dracula, nord,
                         # gruvbox-dark, one-dark, solarized-dark,
                         # material-ocean, rose-pine, github-dark
```

## Troubleshooting

<details>
<summary><b>Tmux plugins not loading</b></summary>

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source-file ~/.config/tmux/tmux.conf
~/.tmux/plugins/tpm/scripts/install_plugins.sh
```

</details>

<details>
<summary><b>SketchyBar plugins not working</b></summary>

```bash
chmod +x ~/.config/sketchybar/plugins/*
brew services restart sketchybar
```

</details>

## Acknowledgments

Built on top of amazing work by [Nikita Bobko](https://github.com/nikitabobko) (AeroSpace), [Felix Kratz](https://github.com/FelixKratz) (SketchyBar), and all the open-source maintainers behind these tools.
