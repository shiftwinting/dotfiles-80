#! /bin/sh
if [ -n "$ENV_SOURCED" ]; then
    :
else
    PATH="$PATH":/sbin
    PATH="$HOME"/.local/bin:"$PATH"
    PATH="$HOME"/bin:"$PATH"
    PATH="$HOME"/.fzf/bin:"$PATH"
    PATH="$HOME"/.vim/plugged/vim-mathpix/bin:"$PATH"
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
export SSH_KEY_PATH="$HOME"/.ssh/rsa_id
export OPENER='xdg-open'
export FZF_BASE=$HOME/.fzf/bin/fzf
export FZF_DEFAULT_COMMAND="rg --files --hidden -g '!.git/*'"
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export BROWSER='firefox'
export TERMINAL='st'
export VIDEO_PLAYER='mpv'
export IMAGE_VIEWER='sxiv'
export PDF_READER='zathura'
export VISUAL="$TERMINAL -e $EDITOR"
export FILE_MANAGER="$TERMINAL -e lf"
export VISUAL_FILE_MANAGER="$TERMINAL -e $FILE_MANAGER"
export EMAIL_CLIENT='neomutt'
export VISUAL_EMAIL_CLIENT="$TERMINAL -e $EMAIL_CLIENT"
export NO_AT_BRIDGE=1
export SCREENLOCKER='i3lock-fancy'
export MATHPIX_GROUP="mrsommerfeld_pm_me"
export MATHPIX_ID="mrsommerfeld_pm_me"
export MATHPIX_KEY="788001c074fadc6419af"
