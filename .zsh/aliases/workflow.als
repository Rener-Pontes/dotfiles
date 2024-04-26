### workflow.als ###

alias cat='batcat'

## LS aliases
alias ls='exa --color=always --group-directories-first'		# Using exa with flags
alias la='exa -a --color=always --group-directories-first'	# Using e
alias ll='exa -lh --color=always --group-directories-first'
alias lla='exa -lah --color=always --group-directories-first'
alias lt='exa -T --color=always --group-directories-first'
alias llt='exa -Tlah --color=always --group-directories-first'
alias l.='exa -a | egrep "^\."'

## CD aliases
alias ..='cd ..'
alias ~='cd ~'

## GREP aliases
alias grep='grep --color=always'
alias egrep='egrep --color=always'
alias fgrep='fgrep --color=always'

## EDITOR aliases
alias nano='micro'
alias vim='nvim'

## DIR MANIPULATION aliases
alias mkdir='mkdir -p'
alias rm='rm -r'

## CONFIRMATION COMMANDS aliases
alias cp='cp -i'
alias mv='mv -i'
alias ln='ln -i'

