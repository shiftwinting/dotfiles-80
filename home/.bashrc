# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
case $- in
    *i*) stty -ixon
        ;;
      *) return
          ;;
esac

# shellcheck source=/dev/null
[ -r  ~/.config/sh/shinit ] && . ~/.config/sh/shinit

exists zsh && [ -z "$BASH_EXECUTION_STRING" ] && [ -z "$USE_BASH" ] && exec zsh


safesource /usr/share/git/completion/git-prompt.sh || safesource /usr/lib/git-core/git-sh-prompt

PS1="\[\033[38;1;32m\]\u\[$(tput sgr0)\]\[\033[38;1;37m\]@\[$(tput sgr0)\]\[\033[38;1;36m\]\h\[$(tput sgr0)\]\[\033[38;1;37m\]:\[$(tput sgr0)\]\[\033[38;0;33m\]\w\[$(tput sgr0)\]$(__git_ps1 " (%s)")[\[\033[38;0;31m\]\$?\[$(tput sgr0)\]]\$ "
export PS1


HISTFILE="$XDG_CACHE_HOME"/bash_history
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

shopt -s autocd

bind '"\eh": "\C-a\eb\ed\C-y\e#man \C-y\C-m\C-p\C-p\C-a\C-d\C-e"'

if exists fzf; then
    safesource ~/.fzf/shell/completion.bash
    safesource ~/.fzf/shell/key-bindings.bash
fi
