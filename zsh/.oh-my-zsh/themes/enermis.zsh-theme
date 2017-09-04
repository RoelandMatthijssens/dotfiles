function theme_precmd {
    local TERMWIDTH
    (( TERMWIDTH = ${COLUMNS} - 1 ))


    ###
    # Truncate the path if it's too long.
    PR_PWDLEN=""
    local pwdsize=${#${(%):-%~}}
    if [[ "$pwdsize" -gt $TERMWIDTH/2 ]]; then
      ((PR_PWDLEN=$TERMWIDTH/2))
    fi
}


setopt extended_glob
theme_preexec () {
    if [[ "$TERM" == "screen" ]]; then
    local CMD=${1[(wr)^(*=*|sudo|-*)]}
    echo -n "\ek$CMD\e\\"
    fi
}


setprompt () {
    ###
    # Need this so the prompt will work.

    setopt prompt_subst


    ###
    # See if we can use colors.

    autoload zsh/terminfo
    for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE GREY; do
    eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
    eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
    (( count = $count + 1 ))
    done
    PR_NO_COLOUR="%{$terminfo[sgr0]%}"

    ###
    # Modify Git prompt
    ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[green]%}"
    ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
    ZSH_THEME_GIT_PROMPT_DIRTY=""
    ZSH_THEME_GIT_PROMPT_CLEAN=""

    ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%} ✚"
    ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%} ✹"
    ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✖"
    ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%} ➜"
    ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%} ═"
    ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} ✭"

    ###
    # See if we can use extended characters to look nicer.
    # UTF-8 Fixed

    if [[ $(locale charmap) == "UTF-8" ]]; then
    PR_SHIFT_IN=""
    PR_SHIFT_OUT=""
    PR_HBAR="─"
        PR_ULCORNER="┌"
        PR_LLCORNER="└"
        PR_LRCORNER="┘"
        PR_URCORNER="┐"
        PR_LEFT_T="├"
        PR_ARROW="→"
    else
        typeset -A altchar
        set -A altchar ${(s..)terminfo[acsc]}
        # Some stuff to help us draw nice lines
        PR_SHIFT_IN="%{$terminfo[smacs]%}"
        PR_SHIFT_OUT="%{$terminfo[rmacs]%}"
        PR_HBAR='$PR_SHIFT_IN${altchar[q]:--}$PR_SHIFT_OUT'
        PR_ULCORNER='$PR_SHIFT_IN${altchar[l]:--}$PR_SHIFT_OUT'
        PR_LLCORNER='$PR_SHIFT_IN${altchar[m]:--}$PR_SHIFT_OUT'
        PR_LRCORNER='$PR_SHIFT_IN${altchar[j]:--}$PR_SHIFT_OUT'
        PR_URCORNER='$PR_SHIFT_IN${altchar[k]:--}$PR_SHIFT_OUT'
        PR_LEFT_T="|"
        PR_ARROW=">"
     fi


    # Finally, the prompt.

    PROMPT='
$PR_CYAN$PR_ULCORNER$PR_HBAR $PR_CYAN%(!.%SROOT%s.%n) $PR_GREY($PR_GREEN%$PR_PWDLEN<...<%~%<<$PR_GREY)
$PR_CYAN$PR_LEFT_T$PR_HBAR $PR_YELLOW%D{%H:%M:%S} $PR_LIGHT_BLUE%{$reset_color%}`virtualenv_prompt_info`\
$PR_RED`git_prompt_short_sha`%{$reset_color%}`git_prompt_info``git_prompt_status`
$PR_CYAN$PR_LLCORNER$PR_HBAR %(?.%{$PR_GREEN%}.%{$fg[red]%})% $PR_ARROW\
$PR_NO_COLOUR '

    return_code="%(?..%{$fg[red]%}%? ↵)"
    RPROMPT='$return_code $PR_YELLOW$DURATION sec %{$reset_color%}'
}

setprompt

autoload -U add-zsh-hook
add-zsh-hook precmd  theme_precmd
add-zsh-hook preexec theme_preexec

