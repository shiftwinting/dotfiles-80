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
    export TERMINAL='urxvt'
    export VISUAL='urxvt -e nvim'
    export fish_greeting=
    export NNN_USER_EDITOR=1
    export NNN_OPENER=mimeopen
    export NNN_OPS_PROG=1
    export FILE_MANAGER='nnn'
else
    export ENV_SOURCED=yes
fi
