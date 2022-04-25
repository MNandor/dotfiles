alias grep="grep -i --color=auto"
alias ls='ls --color=auto -lh --group-directories-first'
alias diff="diff --color"

alias shutdown='shutdown now'
alias rm='rm -i'
alias syu='sudo pacman -Syu'
alias pid="ps -aux | grep"
alias howmuchspaceisonmydrives='df -h'
alias dmenu='dmenu -nb "#000000" -nf "#FF0000" -sf "#000000" -sb "#FF0000" -i -l 5'

alias lgrep='ls | grep'
alias hgrep="history | grep"
alias bgrep='cat ~/.bashrc | grep'
alias vbash='vim ~/.bashrc && source ~/.bashrc'


alias ":q"="exit"
alias ":q!"="exit"
alias quit="exit"
alias ".."="cd .."
alias clcd='cd ~ && clear'

alias py="python3"
alias pip="pip3"
alias xclip='xclip -sel clip'
alias bc='calc'
alias mnt='sudo mount /dev/sda1 /mnt'



# Copy these to clipboard
alias lenny="echo -n '( ͡° ͜ʖ ͡°)' | xclip -sel clip && echo 'Lenny face on clipboard!'"
alias shrug="echo -n '¯\_(ツ)_/¯' | xclip -sel clip && echo 'Shrug face on clipboard!'"



# _____         _    
# |_   _|_ _ ___| | __
#  | |/ _` / __| |/ /
#  | | (_| \__ \   < 
#  |_|\__,_|___/_|\_\

alias td="task add"
alias tdb='td priority:L'
alias tt='td pro:inbox'
alias tw='timew'


# One Letter

alias t="task"
alias v="vim"
alias p="python3"
alias g="git"
alias r="ranger"


#  ____  _          _ _ 
# / ___|| |__   ___| | |
# \___ \| '_ \ / _ \ | |
#  ___) | | | |  __/ | |
# |____/|_| |_|\___|_|_|
                      
# Use arrows to search through history
# Up Arrow
bind '"\e[A": history-search-backward'
# Down Arrow
bind '"\e[B": history-search-forward'
# Default prompt
# export PS1="\[\e[1;45;32m\]\$taskcount\[\e[1;35m\]\u \[\e[4;32m\]\w\[\e[0;40;35m\]\[\e[0m\] "
# Alternative prompt, simpler.
export PS1="\[\e[1;32m\]\$taskcount\[\e[1;35m\]\u \[\e[4;32m\]\w\[\e[0;35m\]\[\e[0m\] > "
promptc(){
	# Taskwarrior task count, to be used in PS1
	taskcount=$(if [ `task status:pending count` != '0' ]; then echo -n "(`task status:pending count`) "; fi)
	# If we're in a git branch, display some info
	gitname=$(basename $(git rev-parse --show-toplevel 2>/dev/null) 2>/dev/null)
	if [ -n "$gitname" ]; then
		username=$(git config user.name)
		usermail=$(git config user.email)
		commitcount=$(git log --oneline | wc -l)
		changecount=$(git status -s | wc -l)
		echo -e "\e[1;33m$gitname\e[0m / \e[1;34m$username\e[0m[\e[1;34m$usermail\e[0m]\e[0m / $commitcount \e[1;32m✓\e[0m $changecount \e[1;33m✗\e[0m"
	fi
}
PROMPT_COMMAND="promptc" 
