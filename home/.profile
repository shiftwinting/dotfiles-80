# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# shellcheck source=/dev/null
[ -r  ~/.config/sh/envrc ] && . ~/.config/sh/envrc
dbus-update-activation-environment --systemd --all

if [ ! "$DISPLAY" ]; then
    if  [ "$XDG_VTNR" = "1" ]; then
        exec startx -- -keeptty
    elif [ -z "$SSH_TTY" ]; then
        [ -r ~/dotfiles/lists/caps2esc.map ] && sudo -n loadkeys ~/dotfiles/lists/caps2esc.map > /dev/null
        sudo -n kbdrate -s -d 250 -r 30 > /dev/null
        if [ "$XDG_VTNR" = "2" ] && [ -t 0 ] && [ -z "$TMUX" ]; then
            exists tmux && exec tmux new-session -A -s tty
        fi
    fi
fi

if [ -n "$BASH" ]; then
    safesource ~/.bashrc
elif [ -n "$ZSH_VERSION" ]; then
    safesource "$XDG_CONFIG_HOME"/zsh/.zshrc
else
    safesource "$XDG_CONFIG_HOME"/sh/shinit
fi
