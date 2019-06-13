# Start X at login
if status is-login
    if test -z "$DISPLAY" -a $XDG_VTNR = 1
        exec startx -- -keeptty
    end
    stty -ixoff
else
    stty -ixon
end

for v in (set --show | string replace -rf '^\$([^:[]+).*: set in universal.*' '$1')
    if test $v != 'history'
        set -e $v
    end
end

# set -xg SHELL /usr/bin/fish
set -xg fish_color_autosuggestion '555'  'yellow'
set -xg fish_color_cancel -r
set -xg fish_color_command '005fd7'  'purple'
set -xg fish_color_comment red
set -xg fish_color_cwd green
set -xg fish_color_cwd_root red
set -xg fish_color_end 009900
set -xg fish_color_error 'red'  '--bold'
set -xg fish_color_escape cyan
set -xg fish_color_history_current cyan
set -xg fish_color_host '-o'  'cyan'
set -xg fish_color_match cyan
set -xg fish_color_normal normal
set -xg fish_color_operator cyan
set -xg fish_color_param '00afff'  'cyan'
set -xg fish_color_quote brown
set -xg fish_color_redirection normal
set -xg fish_color_search_match --background=purple
set -xg fish_color_selection --background=purple
set -xg fish_color_status red
set -xg fish_color_user '-o'  'green'
set -xg fish_color_valid_path --underline
set -xg fish_greeting
set -xg fish_key_bindings fish_default_key_bindings
set -xg fish_pager_color_completion normal
set -xg fish_pager_color_description '555'  'yellow'
set -xg fish_pager_color_prefix cyan
set -xg fish_pager_color_progress cyan

if test -f ~/.aliases.sh
    source ~/.aliases.sh
end
theme_gruvbox dark hard

if test "$TERM" = "xterm-kitty"
    kitty + complete setup fish | source
end
