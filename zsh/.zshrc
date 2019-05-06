# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob nomatch notify
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/sommerfeld/.zshrc'

autoload -Uz compinit promptinit
compinit
promptinit
# Completion for kitty
if [[ $TERM == "xterm-kitty" ]]; then
    kitty + complete setup zsh | source /dev/stdin
fi
zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1
setopt COMPLETE_ALIASES
# End of lines added by compinstall

stty -ixon
prompt oliver


# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.aliases, instead of adding them here directly.
if [ -f ~/.aliases.sh ]; then
    . ~/.aliases.sh
fi

function zle-line-init () { echoti smkx }
function zle-line-finish () { echoti rmkx }
zle -N zle-line-init
zle -N zle-line-finish
