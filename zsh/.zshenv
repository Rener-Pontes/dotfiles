# set EDITOR to nvim, vim
export EDITOR
if [ -x "$(which nvim)" ] ; then
	EDITOR=nvim
elif [ -x "$(which vim)" ] ; then
	EDITOR=vim
fi
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

# set man PAGER
# if command -v nvim > /dev/null 2>&1; then
	# I need to set up this nvim propperly yet
	# export MANPAGER="nvim -c 'set ft=man' -"
if command -v bat >/dev/null 2>&1 || command -v batcat >/dev/null 2>&1; then
	pager_cmd=$(command -v bat || command -v batcat)
	export MANPAGER="sh -c 'col -bx | $pager_cmd -l man -p'"
else
	export MANPAGER='less'
fi

. "$HOME/.cargo/env"
