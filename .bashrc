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

# Shadow common commands with reasonable defaults
alias grep="grep -i --color=auto"
alias ls='ls --color=always -lh --group-directories-first'
alias diff="diff --color"
alias powertop='sudo powertop'
alias tune='sudo powertop --auto-tune'
alias shutdown='shutdown now'
alias suspend='systemctl suspend && slock'
alias rm='rm -i'
alias ifind="find . -iname"
alias syu='sudo pacman -Syu'
alias xclip='xclip -sel clip'
alias watch="watch --color"

# Edit Common Files
alias vbash='vim ~/.bashrc && source ~/.bashrc'
alias vvimrc='vim ~/.vimrc'
alias vqtile='vim ~/.config/qtile/config.py'
