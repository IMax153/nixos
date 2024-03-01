autoload -U compinit && compinit
# autocompletion
autoload -Uz compinit && compinit
# bash-compatible mode
autoload -Uz bashcompinit && bashcompinit
# use cache
zstyle ':completion::complete:*' use-cache 1
# autocompletion menu
zstyle ':completion:*' menu select
# shift-tab to go back in completions
bindkey '^[[Z' reverse-menu-complete
# autocomplete with sudo
zstyle ':completion::complete:*' gain-privileges 1
# case insensitive and partial
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# Defining the Completers
zstyle ':completion:*' completer _extensions _complete _approximate
# display completer while waiting
zstyle ":completion:*" show-completer true
# we need that as long as we use asdf and want autocompletion for those tools
# lazy load zsh completion
completers=(
    # kubectl "kubectl completion zsh"
    # helm "helm completion zsh"
    # k3d "k3d completion zsh"
    # kind "kind completion zsh"
    # flux "flux completion zsh"
    # tilt "tilt completion zsh"
    # poetry "poetry completions zsh"
)
for ((i=1; i<${#completers[@]}; i+=2)); do
    local cmd="${completers[i]}"
    local completer="${completers[i+1]}"
    eval "
    function _lazycomplete_$cmd {
        if command -v $cmd &>/dev/null; then
        unfunction _lazycomplete_$cmd
        # if a dedicated completions file is already handled by package manager
        # do nothing
        if [ ! -f $ZSH_VENDOR_COMPLETIONS/_$cmd ]; then
            compdef -d $cmd
            source <($completer)
            # find the completion function we just sourced, some names are non-deterministic
            local ccmd=\$(print -l \${(ok)functions[(I)_*]} | grep \"$cmd\" | grep --invert-match \"^__\" | grep --invert-match \"debug\" | head -n 1)
            # just in case, some generator commands expect to pass this manually, like tilt
            # and some generate the command badly, like poetry. This is a mess
            compdef \$ccmd $cmd
            \$ccmd \"\$@\"
        else
            # it is already provided by package manager
        fi
        fi
    }
    compdef _lazycomplete_$cmd $cmd
    "
done