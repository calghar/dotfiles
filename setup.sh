#!/bin/bash

# Dotfiles Setup Script
# Automated setup for macOS development environment

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_header() {
    echo -e "\n${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}  Dotfiles Setup${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
}

print_step() { echo -e "${BLUE}▶${NC} $1"; }
print_success() { echo -e "${GREEN}✓${NC} $1"; }
print_warning() { echo -e "${YELLOW}⚠${NC} $1"; }
print_error() { echo -e "${RED}✗${NC} $1"; }

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ── Checks ──────────────────────────────────────────────────────────────────

check_macos() {
    if [[ "$OSTYPE" != "darwin"* ]]; then
        print_error "This script is designed for macOS only."
        exit 1
    fi
    print_success "Running on macOS"
}

check_homebrew() {
    print_step "Checking for Homebrew..."
    if ! command -v brew &> /dev/null; then
        print_warning "Homebrew not found. Installing..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        if [[ -f "/opt/homebrew/bin/brew" ]]; then
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
    fi
    print_success "Homebrew available"
}

check_rust() {
    print_step "Checking for Rust/Cargo..."
    if ! command -v cargo &> /dev/null; then
        print_warning "Rust not found. Installing via rustup..."
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
        source "$HOME/.cargo/env"
    fi
    print_success "Cargo available ($(cargo --version | cut -d' ' -f2))"
}

# ── Install ─────────────────────────────────────────────────────────────────

install_brew_packages() {
    print_step "Installing Homebrew packages..."
    brew bundle install --file="$DOTFILES_DIR/Brewfile" --no-lock
    print_success "Brew packages installed"
}

install_tree_sitter_cli() {
    print_step "Checking tree-sitter-cli (required for Neovim 0.12)..."
    if ! command -v tree-sitter &> /dev/null; then
        print_step "Installing tree-sitter-cli via Cargo..."
        cargo install tree-sitter-cli
    fi
    print_success "tree-sitter-cli available ($(tree-sitter --version))"
}

# ── Submodules ──────────────────────────────────────────────────────────────

init_submodules() {
    print_step "Initializing git submodules (zsh plugins)..."
    cd "$DOTFILES_DIR"
    git submodule update --init --recursive
    print_success "Submodules initialized"
}

# ── Symlinks ────────────────────────────────────────────────────────────────

backup_and_link() {
    local src="$1"
    local dest="$2"
    local backup_dir="$DOTFILES_DIR/.backup_$(date +%Y%m%d)"

    # Already correctly linked
    if [[ -L "$dest" ]] && [[ "$(readlink "$dest")" == "$src" ]]; then
        return
    fi

    # Backup existing file/dir
    if [[ -e "$dest" ]] || [[ -L "$dest" ]]; then
        mkdir -p "$backup_dir"
        mv "$dest" "$backup_dir/$(basename "$dest")"
        print_warning "Backed up existing $(basename "$dest") to .backup_*/"
    fi

    ln -sfn "$src" "$dest"
}

setup_symlinks() {
    print_step "Symlinking configurations..."

    mkdir -p "$HOME/.config"

    # Directories → ~/.config/
    local config_dirs=(
        aerospace atuin btop cava fish ghostty
        neovide nvim sketchybar skhd starship tmux yazi zsh
    )

    for dir in "${config_dirs[@]}"; do
        if [[ -d "$DOTFILES_DIR/$dir" ]]; then
            backup_and_link "$DOTFILES_DIR/$dir" "$HOME/.config/$dir"
        fi
    done

    # Fastfetch has a nested .config structure
    if [[ -d "$DOTFILES_DIR/fastfetch" ]]; then
        backup_and_link "$DOTFILES_DIR/fastfetch" "$HOME/.config/fastfetch"
    fi

    # Files → ~/
    backup_and_link "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"

    print_success "Symlinks created"
}

# ── Tmux ────────────────────────────────────────────────────────────────────

setup_tmux() {
    print_step "Setting up Tmux plugins..."

    local tpm_dir="$HOME/.tmux/plugins/tpm"
    if [[ ! -d "$tpm_dir" ]]; then
        git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
    fi

    "$tpm_dir/bin/install_plugins" 2>/dev/null || true
    print_success "Tmux plugins installed"
}

# ── Neovim ──────────────────────────────────────────────────────────────────

setup_neovim() {
    print_step "Setting up Neovim..."

    mkdir -p "$HOME/.local/share/nvim"
    mkdir -p "$HOME/.local/state/nvim"

    # Sync lazy.nvim plugins headlessly
    if command -v nvim &> /dev/null; then
        print_step "Installing Neovim plugins (this may take a moment)..."
        nvim --headless "+Lazy! sync" +qa 2>/dev/null || true
        print_success "Neovim plugins synced"
        print_warning "Treesitter parsers compile on first real launch (~30s)"
    fi
}

# ── Services ────────────────────────────────────────────────────────────────

setup_services() {
    print_step "Setting up services..."

    if command -v sketchybar &> /dev/null; then
        chmod +x "$HOME/.config/sketchybar/plugins/"* 2>/dev/null || true
        brew services start sketchybar 2>/dev/null || true
        print_success "SketchyBar started"
    fi

    if command -v skhd &> /dev/null; then
        brew services start skhd 2>/dev/null || true
        print_success "SKHD started"
    fi

    print_warning "AeroSpace: start manually or add to Login Items"
}

# ── Main ────────────────────────────────────────────────────────────────────

main() {
    print_header

    check_macos
    check_homebrew
    check_rust

    install_brew_packages
    install_tree_sitter_cli
    init_submodules

    setup_symlinks
    setup_tmux
    setup_neovim
    setup_services

    echo -e "\n${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}  Setup complete!${NC}"
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

    echo -e "${YELLOW}Next steps:${NC}"
    echo -e "  1. Restart your terminal (or source ~/.zshrc)"
    echo -e "  2. Open nvim — treesitter parsers will compile on first launch"
    echo -e "  3. Start AeroSpace from Applications or add to Login Items"
    echo -e "  4. (Optional) Create ~/.zshrc.local for machine-specific config"
    echo -e "  5. (Optional) cp aerospace/aerospace-personal.toml.example aerospace/aerospace-personal.toml"
    echo ""
}

main "$@"
