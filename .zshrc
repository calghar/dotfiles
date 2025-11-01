# ╭──────────────────────────────────────────────────────────╮
# │                    ZSH Configuration                     │
# ╰──────────────────────────────────────────────────────────╯

# PATH setup
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/bin:$PATH"

# Preserved paths from previous configuration
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export PATH="$HOME/.rd/bin:$PATH"
export PATH="$HOME/scripts/:$PATH"

# Environment variables
export STARSHIP_CONFIG=~/.config/starship/starship.toml
export EDITOR="nvim"
export LDFLAGS="-L/opt/homebrew/lib"
export CPPFLAGS="-I/opt/homebrew/include"

# ╭──────────────────────────────────────────────────────────╮
# │                    Shell Settings                        │
# ╰──────────────────────────────────────────────────────────╯

# Enable completions
autoload -Uz compinit
compinit

# Vi mode
bindkey -v
export KEYTIMEOUT=1

# History settings
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt SHARE_HISTORY
setopt HIST_VERIFY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS

# ╭──────────────────────────────────────────────────────────╮
# │                     Tool Integration                     │
# ╰──────────────────────────────────────────────────────────╯

# Initialize tools
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(thefuck --alias fk)"
eval "$(atuin init zsh)"

# FZF integration
source <(fzf --zsh)

# ZSH plugins (from dotfiles)
[[ -f ~/dotfiles/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && source ~/dotfiles/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[[ -f ~/dotfiles/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && source ~/dotfiles/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# ╭──────────────────────────────────────────────────────────╮
# │                      Functions                           │
# ╰──────────────────────────────────────────────────────────╯

# Yazi wrapper function
y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

# ╭──────────────────────────────────────────────────────────╮
# │                       Aliases                            │
# ╰──────────────────────────────────────────────────────────╯

# Modern CLI replacements with icons
alias ls="eza --color=always --group-directories-first --icons"
alias ll="eza -la --color=always --group-directories-first --icons"
alias la="eza -a --color=always --group-directories-first --icons"
alias lt="eza -aT --color=always --group-directories-first --icons"
alias l.="eza -a | grep -E '^\\.'"
alias cat="bat --paging=never"

# NVIM aliases
alias nvchad="NVIM_APPNAME='nvchad' nvim"
alias lazyvim="NVIM_APPNAME='lazyVim' nvim"
alias astro="NVIM_APPNAME='astroNvim' nvim"
alias kickstart="NVIM_APPNAME='kickstart' nvim"

# Git aliases
alias gl="git clone"
alias gss="git status"
alias ga="git add"
alias gaa="git add --all"
alias gm="git commit"
alias gmm="git commit -m"
alias gb="git branch"
alias gbr="git branch -r"
alias gk="git checkout"
alias gkb="git checkout -b"
alias gkt="git checkout -t"
alias glg="git log"
alias glgo="git log --oneline"
alias gw="git switch"

# Fastfetch aliases
alias ff="fastfetch --config ~/.config/fastfetch/config.jsonc"
alias fff="fastfetch --config ~/.config/fastfetch/config-fast.jsonc"
alias ffff="fastfetch --config ~/.config/fastfetch/config-ultra-fast.jsonc"

# SketchyBar theme switcher alias
alias theme="~/.config/sketchybar/switch_theme.sh"

# Kubectl completion (if available)
[[ $commands[kubectl] ]] && source <(kubectl completion zsh)

# Show system info with Apple logo on startup (only for new terminal windows)
if [[ -z "$TMUX" && -z "$FASTFETCH_SHOWN" ]]; then
    export FASTFETCH_SHOWN=1
    fastfetch --config ~/.config/fastfetch/config-ultra-fast.jsonc
fi

# ╭──────────────────────────────────────────────────────────╮
# │                    Shell Settings                        │
# ╰──────────────────────────────────────────────────────────╯


# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=($HOME/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions
