#! /bin/sh

safesource() {
# shellcheck source=/dev/null
    [ -f "$1" ] && . "$1"
}

exists() {
    command -v "$1" > /dev/null 2>&1
}

if [ -n "$ENV_SOURCED" ]; then
    :
else
    if [ -z "$OLDPATH" ]; then
        export OLDPATH="$PATH"
    else
        PATH="$OLDPATH"
    fi
    PATH="$HOME"/.local/bin:"$PATH"
    if ! [ -x "/usr/bin/fzf" ] && ! [ -x "/usr/local/bin/fzf" ]; then
        PATH="$HOME"/.fzf/bin:"$PATH"
    fi
    if [ "$(hostname)" = "liselle" ]; then
        PATH=/usr/local/cuda/bin:"$PATH"
    fi
    export PATH
    MANPATH="/usr/local/man:$MANPATH"
    MANPATH="$HOME"/.local/share/man:"$MANPATH"
    export MANPATH

    LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH"
    if [ "$(hostname)" = "liselle" ]; then
        LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"
    fi
    export LD_LIBRARY_PATH
    export ENV_SOURCED=yes
fi

GPG_TTY=$(tty)
export GPG_TTY
export GPG_AGENT_INFO=1
export ENV="$HOME"/.shinit
if exists nvim; then
    EDITOR='nvim'
elif exists vim; then
    EDITOR='vim'
else
    EDITOR='vi'
fi
export EDITOR
export VISUAL="$EDITOR"
if exists page; then
    export PAGER="page -q 90000"
    export MANPAGER="page -C -e 'au User PageDisconnect sleep 100m|%y p|enew! |bd! #|pu p|set ft=man'"
fi
export LANG=en_US.UTF-8
export ARCHFLAGS="-arch x86_64"
export OPENER='xdg-open'
export FZF_DEFAULT_COMMAND="rg --files --hidden -g '!.git/*'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--layout=reverse --inline-info --cycle --color=dark --color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f --color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7"
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

if exists w3m; then
    BROWSER='w3m'
else
    BROWSER='firefox'
fi
export BROWSER
export TERMINAL='st'
# Set STATUSBAR for the mailsync script
export STATUSBAR="i3blocks"
# Suppress Gnome Accessibility bus warnings in gtk apps
export NO_AT_BRIDGE=1
# Enable Webrender in firefox for video decode hw acceleration
export MOZ_WEBRENDER=1
if [ "$(hostname)" = "halley" ]; then
# set in new intel iris HD driver for VA-API video hw decoding
    export LIBVA_DRIVER_NAME="iHD"
    export MESA_LOADER_DRIVER_OVERRIDE="iris"
fi
if [ "$(hostname)" = "garry" ]; then
    IFACE=wlo1
elif [ "$(hostname)" = "halley" ]; then
    IFACE=wlan0
fi
export IFACE
export INTERFACE="$IFACE"
