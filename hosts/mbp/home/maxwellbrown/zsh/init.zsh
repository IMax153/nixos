# beeping is annoying
unsetopt beep
# alacritty icon jumping
# https://github.com/alacritty/alacritty/issues/2950#issuecomment-706610878
printf "\e[?1042l"
# enable directories stack
setopt autopushd           # Push the current directory visited on the stack.
setopt pushdignoredups    # Do not store duplicates in the stack.
setopt pushdsilent         # Do not print the directory stack after pushd or popd.
## Reduce latency when pressing <Esc> (helps with vi mode)
export KEYTIMEOUT=1
# fix backspace issues according to https://superuser.com/questions/476532/how-can-i-make-zshs-vi-mode-behave-more-like-bashs-vi-mode/533685#533685
bindkey "^?" backward-delete-char
# Enable to edit command line in $VISUAL
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd '^v' edit-command-line
#### Functions
weather() {
    local param="$1"
    if [ -z "$param" ]; then
    curl "wttr.in/?F"
    else
    curl "wttr.in/${param}?F"
    fi
}
timezsh() {
    local shell=${1-$SHELL}
    for i in $(seq 1 10); do time $shell -i -c exit; done
}