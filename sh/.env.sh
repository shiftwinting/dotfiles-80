#! /bin/sh
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
    export PATH
    MANPATH="/usr/local/man:$MANPATH"
    MANPATH="$HOME"/.local/share/man:"$MANPATH"
    export MANPATH

    IFACE=$(iface.sh) && export IFACE
    export INTERFACE="$IFACE"
    export ENV_SOURCED=yes
fi

export ENV="$HOME"/.shinit
export EDITOR='nvim'
export LANG=en_US.UTF-8
export ARCHFLAGS="-arch x86_64"
export OPENER='xdg-open'
export FZF_BASE=$HOME/.fzf/bin/fzf
export FZF_DEFAULT_COMMAND="rg --files --hidden -g '!.git/*'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--layout=reverse --inline-info --cycle --color=dark --color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f --color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7"
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export BROWSER='firefox'
export TERMINAL='st'
export VIDEO_PLAYER='mpv'
export IMAGE_VIEWER='sxiv'
export PDF_READER='zathura'
export VISUAL="$EDITOR"
export FILE_MANAGER="lf"
export VISUAL_FILE_MANAGER="$TERMINAL -e $FILE_MANAGER"
export EMAIL_CLIENT='neomutt'
export VISUAL_EMAIL_CLIENT="$TERMINAL -e $EMAIL_CLIENT"
export NO_AT_BRIDGE=1
export SCREENLOCKER='i3lock-fancy'
export MOZ_WEBRENDER=1
export LD_LIBRARY_PATH='/usr/local/lib'
