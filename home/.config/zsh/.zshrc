case $- in
    *i*) stty -ixon
        ;;
      *) return
          ;;
esac

ttyctl -f
# shellcheck source=/dev/null
[ -r  ~/.config/sh/shinit ] && . ~/.config/sh/shinit

safesource /usr/share/git/completion/git-prompt.sh || safesource /usr/lib/git-core/git-sh-prompt

# Enable colors and change prompt:
autoload -U colors
colors
setopt PROMPT_SUBST
PROMPT='%B%{$fg[green]%}%n%{$reset_color%}@%{$fg[cyan]%}%m%{$reset_color%}:%b%{$fg[yellow]%}%~%{$reset_color%}$(__git_ps1 " (%s)")%(?..[%{$fg[red]%}%?%{$reset_color%}]) %(!.#.>) '

HISTFILE="$XDG_CACHE_HOME"/zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt appendhistory autocd extendedglob nomatch notify
unsetopt beep
bindkey -e

autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1
zstyle ':completion:*' completer _expand_alias _complete _ignored
setopt COMPLETE_ALIASES
_comp_options+=(globdots)		# Include hidden files.

setopt rmstarsilent

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[ShiftTab]="${terminfo[kcbt]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"      beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"       end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"    overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}" backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"    delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"        up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"      down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"      backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"     forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"    beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"  end-of-buffer-or-history
[[ -n "${key[ShiftTab]}"  ]] && bindkey -- "${key[ShiftTab]}"  reverse-menu-complete

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start {
		echoti smkx
	}
	function zle_application_mode_stop {
		echoti rmkx
	}
        if [ $(hostname) = "garry" ]; then
            add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
            add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
        fi
fi

if [ -n "$DISPLAY" ]; then
    function zle-line-init () { echoti smkx }
    function zle-line-finish () { echoti rmkx }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search

bindkey \^U backward-kill-line

exit_zsh() { exit }
zle -N exit_zsh
bindkey '^D' exit_zsh

bash() {
    export USE_BASH="yes"
    command bash
}

setopt interactivecomments

autoload -Uz add-zsh-hook

xterm_title_precmd () {
	print -Pn -- '\e]2;%~\a'
}

xterm_title_preexec () {
	print -Pn -- '\e]2;%~ %# ' && print -n -- "${(q)1}\a"
}

if [[ "$TERM" == (st*|screen*|xterm*|rxvt*|tmux*|putty*|konsole*|gnome*) ]]; then
	add-zsh-hook -Uz precmd xterm_title_precmd
	add-zsh-hook -Uz preexec xterm_title_preexec
fi

autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':completion:*:*:cdr:*:*' menu selection

autoload -Uz run-help
alias help=run-help

autoload -Uz run-help-git
autoload -Uz run-help-ip
autoload -Uz run-help-sudo

safesource /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh || safesource ~/repos/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

if [ -n "$ZSH_HIGHLIGHT_STYLES" ]; then
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets cursor)
    ZSH_HIGHLIGHT_STYLES[comment]='fg=yellow'
fi

safesource /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh || safesource ~/repos/zsh-autosuggestions/zsh-autosuggestions.zsh

safesource /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh || safesource ~/repos/zsh-history-substring-search/zsh-history-substring-search.zsh

if [ "$(hostname)" = "liselle" ]; then
    fpath=(~/repos/zsh-completions $fpath)
fi

if exists fzf; then
    safesource ~/.fzf/shell/key-bindings.zsh
    safesource ~/.fzf/shell/completion.zsh
fi

alias please='sudo $(fc -ln -1)'
