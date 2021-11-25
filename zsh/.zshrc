# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/enermis/.oh-my-zsh"
export PATH=~/bin:./bin:$PATH

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="robbyrussell"
ZSH_THEME="powerlevel10k/powerlevel10k"

HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git rbenv virtualenv nvm)

source $ZSH/oh-my-zsh.sh

export EDITOR='vim'

# Virtualenv
#. /usr/local/bin/virtualenvwrapper.sh

# time each command
function preexec() {
    timer=${timer:-$SECONDS}
}
function precmd () {
    if [ $timer ]; then
        export DURATION=$(($SECONDS - $timer))
        unset timer
    fi
}

alias dockerclean="docker ps -a | grep Exited | cut -d ' ' -f 1 | xargs docker rm"
alias dockerrmi="docker images -a | grep '^<none>' | awk '{ print \$3 }' | xargs docker rmi -f"

# Start tmux when zsh is launched
# if which tmux 2>&1 >/dev/null && [ "$TERM" != "screen-256color" ] && [[ -z $SSH_CONNECTION ]]; then
#     export DISABLE_AUTO_TITLE=true
#     test -z "$TMUX" && (exec tmux attach || tmux)
# fi
if [ -z "$TMUX" ]; then
   exec tmux new-session -A -s workspace
fi



# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:./node_modules/.bin"
eval "$(rbenv init -)"

# pipenv
export PIPENV_VENV_IN_PROJECT="enabled"

# platformio
export PATH=$PATH:~/.platformio/penv/bin

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# node version manager
source /usr/share/nvm/init-nvm.sh

# ls deluxe
alias ls='lsd --group-dirs first'
alias ll='ls -lA'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'

# btop, a htop alternative
alias htop='btop'

# bat, a cat alternative
alias cat='bat'
