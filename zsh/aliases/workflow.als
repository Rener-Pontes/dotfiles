### workflow.als ###

alias cat='batcat'

## LS aliases
alias ls='exa --color=always --group-directories-first --icons'
alias la='exa -a --color=always --group-directories-first --icons'
alias ll='exa -lh --color=always --group-directories-first --icons'
alias lla='exa -lah --color=always --group-directories-first --icons'
alias lt='exa -T --color=always --group-directories-first --icons'
alias lta='exa -Ta --color=always --group-directories-first --icons'
alias llt='exa -Tlh --color=always --group-directories-first --icons'
alias llta='exa -Tlah --color=always --group-directories-first --icons'
alias l.='exa -d --group-directories-first --icons .*'
alias ll.='exa -ld --group-directories-first --icons .*'

## CD aliases
alias cd='z'
alias ..='cd ..'
alias ~='cd ~'

## GREP aliases
alias grep='rgrep --color=always'
alias egrep='egrep --color=always'
alias fgrep='fgrep --color=always'

## EDITOR aliases
alias nano='micro'
alias vim='nvim'

## DIR MANIPULATION aliases
alias mkdir='mkdir -p'
alias rm='rm -r'
alias cp='cp -r'
alias rmf='rm -rf'

## CONFIRMATION COMMANDS aliases
alias cp='cp -i'
alias mv='mv -i'
alias ln='ln -i'


alias facul='cd ~/Documents/Ciências\ da\ Computação/'

## TO EASY MY LIFE WHEN CODING
alias cbuild='cmake --build build'
alias ctest='ctest --test-dir build --output-on-failure --progress'
alias cbuildtest='cbuild && echo -e "\n"; ctest'

