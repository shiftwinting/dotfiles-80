if [ -n "$ENV_SOURCED" ]; then
    export PATH="$PATH":/sbin
    export PATH="$PATH":/snap/bin
    export PATH="$HOME"/.local/bin:"$PATH"
    export PATH="$HOME"/bin:"$PATH"
    export PATH="$HOME"/.yarn/bin:"$PATH"
    export PATH="$HOME"/.config/yarn/global/node_modules/.bin:"$PATH"
    export PATH="$HOME"/.fzf/bin:"$PATH"

    export EDITOR='nvim'
    export MANPATH="/usr/local/man:$MANPATH"
    export LANG=en_US.UTF-8
    export ARCHFLAGS="-arch x86_64"
    export SSH_KEY_PATH="$HOME"/.ssh/rsa_id
    export FZF_BASE=$HOME/.fzf/bin/fzf
    export FZF_DEFAULT_COMMAND="rg --files --hidden -g '!.git/*' -g '!.cache/*'
    -g '!.local/*'"
    export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
    export BROWSER='firefox'
    export TERMINAL='st'
    export VIDEO_PLAYER='mpv'
    export IMAGE_VIEWER='sxiv'
    export PDF_READER='zathura'
    export VISUAL="$TERMINAL -e $EDITOR"
    export fish_greeting=
    export NNN_USER_EDITOR=1
    export NNN_OPENER='mimeopen -n'
    export NNN_OPS_PROG=1
    export FILE_MANAGER='nnn'
    export VISUAL_FILE_MANAGER="$TERMINAL -e $FILE_MANAGER"
    export EMAIL_CLIENT='neomutt'
    export VISUAL_EMAIL_CLIENT="$TERMINAL -e $EMAIL_CLIENT"
    export NO_AT_BRIDGE=1
    export SCREENLOCKER='i3lock-fancy'
else
    export ENV_SOURCED=yes
fi
