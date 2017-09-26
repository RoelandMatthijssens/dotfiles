# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export TERMINFO=~/.terminfo
export ZSH=/home/enermis/.oh-my-zsh
export TERM=xterm-256color
export PATH=./bin:$PATH
#export SHELL=/bin/zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="enermis"

HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git virtualenv)

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

alias mylocal="echo dev; mycli -pdev mysql://root@0.0.0.0:33066/mvne"
alias myecho="echo Su0O5HHxZ7; mycli -pSu0O5HHxZ7 mysql://mvne@mysqldev1.internal.vikingco.com:3313/mvne"
alias mydelta="echo Su0O5HHxZ6; mycli -pSu0O5HHxZ6 mysql://mvne@mysqldev1.internal.vikingco.com:3312/mvne"
alias dockerclean="docker ps -a | grep Exited | cut -d ' ' -f 1 | xargs docker rm"
alias dockerrmi="docker images -a | grep '^<none>' | awk '{ print \$3 }' | xargs docker rmi -f"
alias gis="git status"
alias vpn="sudo openvpn --config ~/tools/openvpn/client.ovpn"

# Start tmux when zsh is launched
if which tmux 2>&1 >/dev/null && [ "$TERM" != "screen-256color" ]; then
    export DISABLE_AUTO_TITLE=true
    test -z "$TMUX" && (tmux attach || tmux)
fi

