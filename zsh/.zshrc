# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
# export ZSH="/home/enermis/.oh-my-zsh"
export PATH=~/bin:./bin:$PATH
export PATH=/home/enermis/.local/bin:$PATH
export PATH=/home/enermis/.gem/ruby/3.0.0/bin:$PATH

# export DEFAULT_USER="enermis"
# export TERM="xterm-256color"
export ZSH=/usr/share/oh-my-zsh
export ZSH_POWER_LEVEL_THEME=/usr/share/zsh-theme-powerlevel10k
export ZSH_CUSTOM=/home/enermis/.oh-my-zsh/custom

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="robbyrussell"
ZSH_THEME="powerlevel10k/powerlevel10k"

export TERMINAL=kitty

HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  rbenv
  virtualenv
  nvm
  bundler
  docker
  jsontools
  k
  colored-man-pages
  colorize
  command-not-found
  cp
  dirhistory
  zsh-syntax-highlighting
  zsh-autosuggestions
  tmux
  git
  # gitfast # disabled because it disables the fixup commit autocompletion
)

ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_AUTOSTART_ONCE=true
ZSH_TMUX_UNICODE=true
ZSH_TMUX_FIXTERM=true
export EDITOR='vim'

# Virtualenv
#. /usr/local/bin/virtualenvwrapper.sh

# time each command
alias dockerclean="docker ps -a | grep Exited | cut -d ' ' -f 1 | xargs docker rm"
alias dockerrmi="docker images -a | grep '^<none>' | awk '{ print \$3 }' | xargs docker rmi -f"

# Start tmux when zsh is launched
# if which tmux 2>&1 >/dev/null && [ "$TERM" != "screen-256color" ] && [[ -z $SSH_CONNECTION ]]; then
#     export DISABLE_AUTO_TITLE=true
#     test -z "$TMUX" && (exec tmux attach || tmux)
# fi
# if [ -z "$TMUX" ]; then
#    # exec tmux new-session -A -s workspace
#    exec tmux
# fi

# Add RBENV to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:./node_modules/.bin"
eval "$(rbenv init -)"
# pipenv
export PIPENV_VENV_IN_PROJECT="enabled"

# platformio
export PATH=$PATH:~/.platformio/penv/bin

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# node version manager
# source /usr/share/nvm/init-nvm.sh

# ls deluxe
alias ls='lsd --group-dirs first'
alias ll='ls -lA'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
# alias lt='ls --tree'

# btop, a htop alternative
alias htop='btop'

# bat, a cat alternative
alias cat='bat'
alias vim='nvim'

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

source /usr/share/nvm/init-nvm.sh
source ~/.nvm/nvm.sh

# Add avn
[[ -s "$HOME/.avn/bin/avn.sh" ]] && source "$HOME/.avn/bin/avn.sh" # load avn


source $ZSH/oh-my-zsh.sh
source ~/powerlevel10k/powerlevel10k.zsh-theme

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY

# Android development
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
source /etc/profile
