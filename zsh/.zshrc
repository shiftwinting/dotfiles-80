stty -ixon
# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh"

# Set fzf installation directory path
export FZF_BASE=$HOME/.fzf/bin/fzf

# Uncomment the following line to disable fuzzy completion
# export DISABLE_FZF_AUTO_COMPLETION="true"

# Uncomment the following line to disable key bindings (CTRL-T, CTRL-R, ALT-C)
# export DISABLE_FZF_KEY_BINDINGS="true"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="mortalscumbag"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  colored-man-pages
  colorize
  command-not-found
  compleat
  copydir
  copyfile
  extract
  pip
  common-aliases
  history
  sudo
  systemd
  fzf
)

source $ZSH/oh-my-zsh.sh

# To add support for TTYs this line can be optionally added.
export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

export EDITOR='vim'
# bindkey -v
# export KEYTIMEOUT=1

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"


path+=/snap/bin
path+=/usr/local/texlive/2017/bin/x86_64-linux
path+=${HOME}/.local/bin
path+=/sbin
export PATH
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
alias ace='acestream-launcher'
alias ipecho='curl ipecho.net/plain; echo'
alias nv-settings='optirun -b none nvidia-settings -c :8'
alias primusrun="vblank_mode=0 primusrun"
alias pip2update="pip2 list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip2 install -U"
alias pip3update="pip3 list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip3 install -U"
export FZF_DEFAULT_COMMAND="rg --files --hidden -g !'.git/*' -g !'*deps*' -g !'*3rd-party*'"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

autoload -Uz compinit
compinit
# Completion for kitty
if [[ $TERM == "xterm-kitty" ]]; then
    kitty + complete setup zsh | source /dev/stdin
fi

