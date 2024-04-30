### workflow.als ###

alias cat='batcat'

## LS aliases
alias ls='exa --color=always --group-directories-first --icons'		# Using exa with flags
alias la='exa -a --color=always --group-directories-first --icons'	# Using e
alias ll='exa -lh --color=always --group-directories-first --icons'
alias lla='exa -lah --color=always --group-directories-first --icons'
alias lt='exa -T --color=always --group-directories-first --icons'
alias llt='exa -Tlah --color=always --group-directories-first --icons'
alias l.='exa -a --group-directories-first --icons | egrep "^. \."'

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


alias facul='cd ~/Documentos/Ciências\ da\ Computação/'
