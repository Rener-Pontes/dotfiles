# If you come from bash you might have to change your $PATH.
# export PATH="path/to/you/path:$PATH"

# Path to your oh-my-zsh installation.
export OMZ="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
export ZSH_CUSTOM="$ZDOTDIR"

# source ~/.zsh/misc/zsh-syntax-highlighting-master/zsh-syntax-highlighting.sh

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	#OMZ builtin plugins
	asdf
	composer
	git
	git-flow
	git-lfs
	golang
	laravel
	rust
	zoxide

	# Custom plugins
	zsh-autosuggestions
	zsh-syntax-highlighting
	fzf-tab
	fzf
)

source $OMZ/oh-my-zsh.sh

# User configuration
export HISTCONTROL=ignoreboth
export HISTDUP=erase

export XDG_CONFIG_HOME="$HOME/.config"

local zsh_aliases="$ZDOTDIR/aliases"
local zsh_functions="$ZDOTDIR/functions"
local zsh_completions="$ZDOTDIR/completions"
local zsh_misc="$ZDOTDIR/misc"

source_files () {
	local dir=$1
	for file in $(command ls $dir); do
		source "$dir/$file"
	done
}

# Sourcing all personal aliases.
[ -d "$zsh_aliases/" ] && source_files $zsh_aliases

# Sourcing all personal functions.
[ -d "$zsh_functions/" ] && source_files $zsh_functions

# Sourcing all command completions.
[ -d "$zsh_completions/" ] && fpath+=("$zsh_completions")

# Sourcing some custom and random configs
[ -d "$zsh_misc/" ] && source_files $zsh_misc


# ASDF configs
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"


setopt vi

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'exa $realpath'

# Setting the STARSHIP PROMPT
eval "$(starship init zsh)"
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"

autoload -U compinit; compinit
