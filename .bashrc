#
# ~/.bashrc
#
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

 Single-letter shortcuts
alias g="git"
alias p="python3"
alias r="ranger"
alias t="task"
alias v="vim"
# w = (show logged in users, not an alias)
alias x="xdg-open"
alias open="xdg-open"


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
