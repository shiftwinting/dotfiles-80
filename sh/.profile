# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# source environment variables
systemctl --user import-environment PATH
[ -r ~/.env.sh ] && . ~/.env.sh

if [ ! "$DISPLAY" -a "$XDG_VTNR" = "1" ]; then
  exec startx -- -keeptty
fi

if [ -n "$BASH" -a -z "$DISPLAY" ]; then
    . ~/.bashrc
else
    . ~/.shinit
fi

if [ "$TERM" = "tmux-256color" ]; then
    . ~/.bashrc
fi
