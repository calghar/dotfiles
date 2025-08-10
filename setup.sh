#!/bin/bash

# 🏠 Dotfiles Setup Script
# Automated setup for macOS development environment

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print functions
print_header() {
    echo -e "\n${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}  🏠 Dotfiles Setup${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
}

print_step() {
    echo -e "${BLUE}▶${NC} $1"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

# Check if running on macOS
check_macos() {
    if [[ "$OSTYPE" != "darwin"* ]]; then
        print_error "This script is designed for macOS only."
        exit 1
    fi
    print_success "Running on macOS"
}

# Check if Homebrew is installed
check_homebrew() {
    print_step "Checking for Homebrew..."
    if ! command -v brew &> /dev/null; then
        print_warning "Homebrew not found. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        # Add Homebrew to PATH for Apple Silicon Macs
        if [[ -f "/opt/homebrew/bin/brew" ]]; then
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
    fi
    print_success "Homebrew is available"
}

# Install core applications
install_core_apps() {
    print_step "Installing core applications..."
    
    # Core tools
    local core_tools=(
        "tmux" 
        "neovim"
        "starship"
        "yazi"
        "stow"
        "zoxide"
        "thefuck"
        "fzf"
        "ripgrep"
        "fd"
        "bat"
        "eza"
        "git"
        "atuin"
        "ical-buddy"
    )
    
    for tool in "${core_tools[@]}"; do
        if ! brew list "$tool" &> /dev/null; then
            print_step "Installing $tool..."
            brew install "$tool"
        else
            print_success "$tool already installed"
        fi
    done
}

# Install system tools
install_system_tools() {
    print_step "Installing system tools..."
    
    local system_tools=(
        "btop"
        "fastfetch" 
        "cava"
    )
    
    for tool in "${system_tools[@]}"; do
        if ! brew list "$tool" &> /dev/null; then
            print_step "Installing $tool..."
            brew install "$tool"
        else
            print_success "$tool already installed"
        fi
    done
    
    # Install cask applications
    local cask_apps=(
        "ghostty"
        "neovide"
        "font-jetbrains-mono-nerd-font"
    )
    
    for app in "${cask_apps[@]}"; do
        if ! brew list --cask "$app" &> /dev/null; then
            print_step "Installing $app..."
            brew install --cask "$app"
        else
            print_success "$app already installed"
        fi
    done
}

# Install window management tools
install_window_management() {
    print_step "Installing window management tools..."
    
    # Add taps if not already added
    brew tap nikitabobko/homebrew-aerospace 2>/dev/null || true
    brew tap koekeishiya/formulae 2>/dev/null || true
    brew tap FelixKratz/formulae 2>/dev/null || true
    
    local wm_tools=(
        "nikitabobko/homebrew-aerospace/aerospace"
        "koekeishiya/formulae/skhd"
        "FelixKratz/formulae/sketchybar"
    )
    
    for tool in "${wm_tools[@]}"; do
        if ! brew list "$(basename "$tool")" &> /dev/null; then
            print_step "Installing $tool..."
            brew install "$tool"
        else
            print_success "$(basename "$tool") already installed"
        fi
    done
}

# Backup existing configurations
backup_existing_configs() {
    print_step "Backing up existing configurations..."
    
    local config_dirs=(
        ".config/tmux"
        ".config/nvim"
        ".config/neovide"
        ".config/starship"
        ".config/yazi"
        ".config/ghostty"
        ".config/aerospace"
        ".config/atuin"
        ".config/btop"
        ".config/cava"
        ".config/fastfetch"
        ".config/sketchybar"
        ".config/skhd"
        ".config/zsh"
    )
    
    local config_files=(
        ".zshrc"
    )
    
    local backup_dir="$HOME/dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
    local backup_created=false
    
    for dir in "${config_dirs[@]}"; do
        if [[ -d "$HOME/$dir" ]] && [[ ! -L "$HOME/$dir" ]]; then
            if [[ "$backup_created" == false ]]; then
                mkdir -p "$backup_dir"
                backup_created=true
                print_warning "Creating backup at $backup_dir"
            fi
            print_step "Backing up $dir..."
            mv "$HOME/$dir" "$backup_dir/$(basename "$dir")"
        fi
    done
    
    for file in "${config_files[@]}"; do
        if [[ -f "$HOME/$file" ]] && [[ ! -L "$HOME/$file" ]]; then
            if [[ "$backup_created" == false ]]; then
                mkdir -p "$backup_dir"
                backup_created=true
                print_warning "Creating backup at $backup_dir"
            fi
            print_step "Backing up $file..."
            mv "$HOME/$file" "$backup_dir/$(basename "$file")"
        fi
    done
    
    if [[ "$backup_created" == true ]]; then
        print_success "Backup completed at $backup_dir"
    else
        print_success "No existing configurations to backup"
    fi
}

# Setup dotfiles with stow
setup_dotfiles() {
    print_step "Setting up dotfiles with GNU Stow..."
    
    # Create .config directory if it doesn't exist
    mkdir -p "$HOME/.config"
    
    # Stow all configurations
    if stow . --target="$HOME" 2>/dev/null; then
        print_success "Dotfiles symlinked successfully"
    else
        print_error "Failed to stow dotfiles. There might be conflicting files."
        print_warning "Try running: stow --adopt . (this will overwrite conflicting files)"
        exit 1
    fi
}

# Setup Zsh (if needed)
setup_zsh() {
    print_step "Setting up Zsh..."
    
    local zsh_path="/bin/zsh"
    
    # Check if already using zsh
    if [[ "$SHELL" == "$zsh_path" ]]; then
        print_success "Already using Zsh"
        return
    fi
    
    # Change default shell to zsh if needed
    print_step "Zsh is available but not default shell"
    print_warning "Run 'chsh -s /bin/zsh' manually if you want to switch"
    
    print_success "Zsh setup completed"
}

# Setup Tmux plugins
setup_tmux() {
    print_step "Setting up Tmux plugins..."
    
    local tpm_dir="$HOME/.tmux/plugins/tpm"
    
    # Install TPM if not already installed
    if [[ ! -d "$tpm_dir" ]]; then
        print_step "Installing Tmux Plugin Manager (TPM)..."
        git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
    fi
    
    # Install tmux plugins
    print_step "Installing Tmux plugins..."
    "$tpm_dir/bin/install_plugins"
    
    print_success "Tmux setup completed"
    # Try to install plugins automatically if tmux is available
    if command -v tmux &> /dev/null; then
        print_step "Installing tmux plugins automatically..."
        # Source the config and install plugins
        tmux source-file "$HOME/.config/tmux/tmux.conf" 2>/dev/null || true
        "$tpm_dir/scripts/install_plugins.sh" 2>/dev/null || true
        print_success "Tmux plugins installed"
    else
        print_warning "Start tmux and press Ctrl+B + I if plugins need manual installation"
    fi
}

# Setup Neovim
setup_neovim() {
    print_step "Setting up Neovim..."
    
    # Create necessary directories
    mkdir -p "$HOME/.local/share/nvim"
    mkdir -p "$HOME/.local/state/nvim"
    
    print_success "Neovim setup completed"
    print_warning "Launch nvim to complete plugin installation automatically"
}

# Setup services (optional)
setup_services() {
    print_step "Setting up system services..."
    
    # SketchyBar
    if command -v sketchybar &> /dev/null; then
        print_step "Setting up SketchyBar..."
        # Make plugins executable
        chmod +x ~/.config/sketchybar/plugins/*
        # Start SketchyBar service
        brew services start sketchybar 2>/dev/null || true
        print_success "SketchyBar service started"
    fi
    
    # SKHD  
    if command -v skhd &> /dev/null; then
        print_step "Setting up SKHD..."
        brew services start skhd 2>/dev/null || true
        print_success "SKHD service started"
    fi
    
    print_warning "Note: AeroSpace needs to be started manually or added to Login Items"
}

# Main setup function
main() {
    print_header
    
    # Check prerequisites
    check_macos
    check_homebrew
    
    # Install applications
    install_core_apps
    install_system_tools
    install_window_management
    
    # Setup configurations
    backup_existing_configs
    setup_dotfiles
    setup_zsh
    setup_tmux
    setup_neovim
    setup_services
    
    # Final message
    echo -e "\n${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}  🎉 Setup completed successfully!${NC}"
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
    
    echo -e "${YELLOW}Next steps:${NC}"
    echo -e "  1. Restart your terminal or open a new tab"
    echo -e "  2. Launch Neovim to complete plugin installation: ${BLUE}nvim${NC}"
    echo -e "  3. Start AeroSpace from Applications or add it to Login Items"
    echo -e "  4. Enjoy your customized development environment!"
    echo -e "\n${GREEN}Enjoy your new development environment! 🚀${NC}\n"
}

# Run main function
main "$@"