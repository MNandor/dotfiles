#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '


# Quick scripting
alias pp="vim /tmp/r.py"
alias bb="vim /tmp/r.sh"
alias kk="vim /tmp/r.kts"

# Exits
alias ":q"="exit"
alias ":q!"="exit"
alias "ZQ"="exit"
alias quit="exit"

# Edit Common Files
alias vbash='vim ~/.bashrc && source ~/.bashrc'
alias vvimrc='vim ~/.vimrc'
alias vqtile='vim ~/.config/qtile/config.py'
