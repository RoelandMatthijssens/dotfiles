# =============================================================================
# .zshrc
# =============================================================================

# -----------------------------------------------------------------------------
# Tmux autostart
# Attach to existing 'main' session or create it. exec replaces the shell
# process with tmux so there's no orphan zsh sitting behind the session.
# Set TMUX_BYPASS=1 to open a plain shell when needed.
# -----------------------------------------------------------------------------
if command -v tmux &>/dev/null && [[ -z "$TMUX" && -z "$TMUX_BYPASS" ]]; then
  exec tmux new-session -A -s main
fi

# -----------------------------------------------------------------------------
# Antidote (plugin manager) — bootstrap on first run, then load plugins
# -----------------------------------------------------------------------------
[[ -d ~/.antidote ]] || git clone --depth=1 https://github.com/mattmc3/antidote.git ~/.antidote
source ~/.antidote/antidote.zsh
antidote load ~/.zsh_plugins.txt

# -----------------------------------------------------------------------------
# Completion
# -----------------------------------------------------------------------------
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ''

# -----------------------------------------------------------------------------
# History
# -----------------------------------------------------------------------------
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=$HISTSIZE
setopt BANG_HIST
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY

# -----------------------------------------------------------------------------
# fzf — fuzzy finder, Ctrl+R history search, Ctrl+T file search
# -----------------------------------------------------------------------------
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

export FZF_DEFAULT_OPTS=" \
  --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
  --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
  --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
  --color=selected-bg:#45475a \
  --height=40% --layout=reverse --border"

# -----------------------------------------------------------------------------
# fnm (Node version manager) — reads .nvmrc automatically
# -----------------------------------------------------------------------------
eval "$(fnm env --use-on-cd --shell zsh)"

# -----------------------------------------------------------------------------
# direnv — per-project environment variables
# -----------------------------------------------------------------------------
eval "$(direnv hook zsh)"

# -----------------------------------------------------------------------------
# kubectl completion (only if installed)
# -----------------------------------------------------------------------------
if command -v kubectl &>/dev/null; then
  source <(kubectl completion zsh)
fi

# -----------------------------------------------------------------------------
# Environment
# -----------------------------------------------------------------------------
export EDITOR='nvim'
export GOPRIVATE=github.com/belgianmobileid/nova-utils

# PATH — go binaries, personal scripts, pipx tools
path=("$HOME/go/bin" "$HOME/bin" "$HOME/.local/bin" $path)
export PATH

# -----------------------------------------------------------------------------
# Aliases
# -----------------------------------------------------------------------------
alias vim='nvim'
alias python='python3'

# nvm → fnm shim: maps common nvm commands to their fnm equivalents
nvm() {
  case "$1" in
    install)    fnm install "${@:2}" ;;
    use)        fnm use "${@:2}" ;;
    ls|list)    fnm list ;;
    ls-remote)  fnm list-remote ;;
    current)    fnm current ;;
    alias)      echo "fnm doesn't have aliases — use 'fnm use <version>' directly" ;;
    *)          echo "nvm is not installed, using fnm. Try: fnm ${*}" ;;
  esac
}

# -----------------------------------------------------------------------------
# Starship prompt
# Loaded last so it can pick up everything set above
# -----------------------------------------------------------------------------
eval "$(starship init zsh)"

# -----------------------------------------------------------------------------
# Welcome
# -----------------------------------------------------------------------------
cat ~/.zsh_welcome
