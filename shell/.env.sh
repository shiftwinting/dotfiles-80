#! /bin/sh
if [ -n "$ENV_SOURCED" ]; then
    :
else
    export PATH="$PATH":/sbin
    export PATH="$HOME"/.local/bin:"$PATH"
    export PATH="$HOME"/bin:"$PATH"
    export PATH="$HOME"/.yarn/bin:"$PATH"
    export PATH="$HOME"/.config/yarn/global/node_modules/.bin:"$PATH"
    export PATH="$HOME"/.gem/ruby/2.6.0/bin:"$PATH"
    export PATH="$HOME"/.fzf/bin:"$PATH"
    export MANPATH="/usr/local/man:$MANPATH"
    export MANPATH="$HOME"/.local/share/man:"$MANPATH"

    [ -f "$HOME"/.sconsify/.cred ] && SCONSIFY_PASSWORD=$(cat "$HOME"/.sconsify/.cred) && export SCONSIFY_PASSWORD

    export ENV_SOURCED=yes
fi

export EDITOR='nvim'
export LANG=en_US.UTF-8
export ARCHFLAGS="-arch x86_64"
export SSH_KEY_PATH="$HOME"/.ssh/rsa_id
export FZF_BASE=$HOME/.fzf/bin/fzf
export FZF_DEFAULT_COMMAND="rg --files --hidden -g '!.git/*'"
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export BROWSER='firefox'
export TERMINAL='st'
export VIDEO_PLAYER='mpv'
export IMAGE_VIEWER='sxiv'
export PDF_READER='zathura'
export VISUAL="$TERMINAL -e $EDITOR"
export NNN_USER_EDITOR=1
export NNN_OPENER='mimeopen -n'
export NNN_CONTEXT_COLORS='4321'
export NNN_RESTRICT_0B=1
export NNN_TMPFILE="/tmp/nnn"
export NNN_NOTE="$HOME"/.mynotes
export NNN_COPIER="$HOME"/dotfiles/scripts/bin/copier
export LC_COLLATE="C"
export FILE_MANAGER='nwrap'
export VISUAL_FILE_MANAGER="$TERMINAL -e $FILE_MANAGER"
export EMAIL_CLIENT='neomutt'
export VISUAL_EMAIL_CLIENT="$TERMINAL -e $EMAIL_CLIENT"
export NO_AT_BRIDGE=1
export SCREENLOCKER='i3lock-fancy'
