
alias grep="grep -i --color=auto"
alias ls='ls --color=auto -lh --group-directories-first'
alias diff="diff --color"
alias shutdown='shutdown now'
alias rm='rm -i'
alias dmenu='dmenu -nb "#000000" -nf "#FF0000" -sf "#000000" -sb "#FF0000" -i -l 5'
alias py="python3"
alias pip="pip3"
alias v="vim "
alias vbash='vim ~/.bashrc && source ~/.bashrc'
alias pid="ps -aux | grep"
alias clcd='cd ~ && clear'
alias howmuchspaceisonmydrives='df -h'
alias quit="exit"
alias ":q"="exit"
alias syu='sudo pacman -Syu'
alias xclip='xclip -sel clip'
alias bc='calc'
alias lgrep='ls | grep'
alias hgrep="history | grep"
alias bgrep='cat ~/.bashrc | grep'
# Copy these to clipboard
alias lenny="echo '( ͡° ͜ʖ ͡°)' | xclip -sel clip && echo 'Lenny face on clipboard!'"
alias shrug="echo '¯\_(ツ)_/¯' | xclip -sel clip && echo 'Shrug face on clipboard!'"
alias mnt='sudo mount /dev/sda1 /mnt'

alias umnt='sudo umount /mnt'
alias t="task"
alias td="task add"
alias tdb='td priority:L'
alias tt='td pro:inbox'
alias tw='timew'
# Use arrows to search through history
# Up Arrow
bind '"\e[A": history-search-backward'
# Down Arrow
bind '"\e[B": history-search-forward'
export PS1="\[\e[1;45;32m\]\$taskcount\[\e[1;35m\]\u \[\e[4;32m\]\w\[\e[0;40;35m\]\[\e[0m\] "
promptc(){
		taskcount=$(if [ `task status:pending count` != '0' ]; then echo -n "(`task status:pending count`) "; fi)
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
