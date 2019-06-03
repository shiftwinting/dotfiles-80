# Start X at login
if status is-login
    if test -z "$DISPLAY" -a $XDG_VTNR = 1
        exec startx -- -keeptty
    end
else
    stty -ixon
end

# set -xg SHELL /usr/bin/fish

theme_gruvbox dark hard

if test "$TERM" = "xterm-kitty"
    kitty + complete setup fish | source
end
