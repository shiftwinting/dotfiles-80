#!/usr/bin/env sh

alias ls='ls --color=auto'
alias ll='ls -lhG'
alias la='ls -AlhG'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias gs='git status'
alias gc='git commit'
alias gck='git commit'
alias gpull='git pull'
alias gpush='git push'
alias gd='git diff'
alias glog='git log'
alias gl='git log --oneline --decorate --all --graph'
alias ga='git add'
alias gca='git commit -a'
alias gsub='git submodule'
alias gsubf='git submodule foreach'
alias gr='git remote'
alias gdiff='git difftool'
alias gmt='git mergetool'
alias gmerge='git merge'

alias please='sudo !!'
alias rtfm='man'
alias gimme='sudo chown $USER:$USER'
alias free='free -h'
alias ...='cd ../..'
alias ....='cd ../../..'
alias mkdir='mkdir -p'
alias du='du -h'
alias df='df -h'

alias ipecho='curl ipecho.net/plain; echo'
alias ccat='pygmentize'
alias copy="xclip -selection clipboard; xclip -selection clipboard -o"

alias cpr='rsync --archive -hh --partial --info=stats1 --info=progress2 --modify-window=1'
alias mvr='rsync --archive -hh --partial --info=stats1 --info=progress2 --modify-window=1 --remove-source-files'
alias sub='subliminal download -l en'
alias ports='netstat -tulpena'

alias ndiff='nvim -d'
alias nview='nvim -R'
