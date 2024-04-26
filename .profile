# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
# set PATH so it includes user's private scripts if it exists
if [ -d "$HOME/.scripts" ] ; then
	PATH="$HOME/.scripts:$PATH"
fi

# set EDITOR to nvim, vim
export EDITOR
if [ -x "$(which nvim)" ] ; then
	EDITOR=nvim
elif [ -x "$(which vim)" ] ; then
	EDITOR=vim
fi

# set man PAGER
if [ $EDITOR ] ; then
	PAGER="$EDITOR +Man!"
fi
