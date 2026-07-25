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
git clone --recursive https://github.com/calghar/dotfiles.git ~/dotfiles
cd ~/dotfiles && ./setup.sh
```

The `--recursive` flag pulls zsh plugin submodules. Restart your terminal after setup.

<details>
<summary><b>Manual setup</b></summary>

```bash
# Prerequisites
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Clone with submodules
git clone --recursive https://github.com/calghar/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Install dependencies
brew bundle install
cargo install tree-sitter-cli

# Symlink configs
mkdir -p ~/.config
for dir in aerospace atuin btop cava fastfetch fish ghostty neovide nvim sketchybar skhd starship tmux yazi zsh; do
    ln -sfn ~/dotfiles/$dir ~/.config/$dir
done
ln -sfn ~/dotfiles/.zshrc ~/.zshrc

# Tmux plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
~/.tmux/plugins/tpm/scripts/install_plugins.sh

# Open nvim once to install plugins and compile parsers
nvim --headless "+Lazy! sync" +qa
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
.zshrc              # Shell config (sources ~/.zshrc.local for secrets)
aerospace/          # Tiling WM (base + personal config merge)
atuin/              # Shell history
btop/               # System monitor
cava/               # Audio visualizer + shaders
ghostty/            # Terminal (config, mappings, appearances, shaders)
nvim/               # Editor (NvChad-based, treesitter on main branch)
sketchybar/         # Status bar (items, plugins, themes)
starship/           # Prompt theme (Catppuccin Mocha)
tmux/               # Multiplexer + plugins
yazi/               # File manager
zsh/                # Plugins (submodules: syntax highlighting, autosuggestions)
cheatsheets/        # Quick reference (Neovim, Tmux, Ghostty)
setup.sh            # Bootstrap script
ssm-env-sync.sh     # Sync selected secrets from AWS SSM into ~/.zshrc.local
```

## Secrets from AWS SSM

`~/.zshrc.local` holds machine-local secrets and is never tracked. `ssm-env-sync.sh`
refreshes the subset of them that lives in AWS SSM Parameter Store; only variables
named in the manifest are touched, so hand-written exports are left alone.

```bash
cp ssm-env.manifest.example ~/.config/ssm-env/manifest   # then edit
./ssm-env-sync.sh --check    # report drift, write nothing
./ssm-env-sync.sh            # sync
```

See `--help`. The real manifest is gitignored — parameter paths describe private
infrastructure.

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
theme catppuccin-mocha   # Switch theme (also: dracula, nord,
                         # gruvbox-dark, one-dark, solarized-dark,
                         # material-ocean, rose-pine, github-dark)
```

## Local Overrides

Machine-specific config goes in `~/.zshrc.local` (git-ignored, sourced at end of `.zshrc`). Use it for secrets, work-specific PATHs, or env vars you don't want shared.

## Notes

- **Neovim 0.12**: Uses `nvim-treesitter` on the `main` branch. Requires `tree-sitter-cli` (installed via Cargo) to compile parsers. First launch compiles all parsers (~30s).
- **Zsh plugins**: Loaded as git submodules. If highlighting or suggestions are missing, run `git submodule update --init --recursive`.
- **Cargo PATH**: Ensure `~/.cargo/bin` is in your PATH (rustup does this via `~/.cargo/env`).

## Troubleshooting

<details>
<summary><b>Treesitter errors on Neovim startup</b></summary>

If you see `attempt to call method 'range' (a nil value)`, parsers need recompiling:

```bash
# Ensure tree-sitter-cli is installed
cargo install tree-sitter-cli

# Delete stale parsers and recompile
rm -f ~/.local/share/nvim/lazy/nvim-treesitter/parser/*.so
nvim  # parsers recompile on launch
```

</details>

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

<details>
<summary><b>Zsh plugins missing (no syntax highlighting)</b></summary>

```bash
cd ~/dotfiles
git submodule update --init --recursive
```

</details>

## Acknowledgments

Built on amazing work by [Nikita Bobko](https://github.com/nikitabobko) (AeroSpace), [Felix Kratz](https://github.com/FelixKratz) (SketchyBar), and all the open-source maintainers behind these tools.
