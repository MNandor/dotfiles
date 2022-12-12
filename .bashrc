#  ____            _              
# | __ )  __ _ ___| |__  _ __ ___ 
# |  _ \ / _` / __| '_ \| '__/ __|
# | |_) | (_| \__ \ | | | | | (__ 
# |____/ \__,_|___/_| |_|_|  \___|

HISTSIZE=HISTFILESIZE
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
export EDITOR="vim"
export HISTCONTROL=ignoreboth
export PAGER=vimpager


# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Single-letter shortcuts
alias b=tbp
alias g="git"
# j = autojump
alias p="python3"
alias r="ranger"
alias t="task"
alias v="vim"
# w = (show logged in users, not an alias)
alias x="xdg-open"

# Autojump
[[ -s /etc/profile.d/autojump.sh ]] && source /etc/profile.d/autojump.sh

# Exits
alias ":q"="exit"
alias ":q!"="exit"
alias "ZQ"="exit"
alias quit="exit"


#  ____            _      
# | __ )  __ _ ___(_) ___ 
# |  _ \ / _` / __| |/ __|
# | |_) | (_| \__ \ | (__ 
# |____/ \__,_|___/_|\___|

# Shadow common commands
alias grep="grep -i --color=auto"
alias ls='ls --color=auto -lh --group-directories-first'
alias diff="diff --color"
alias powertop='sudo powertop'
alias shutdown='shutdown now'
alias rm='rm -i'
alias find='find . -name'
alias dmenu='dmenu -nb "#000000" -nf "#FF0000" -sf "#000000" -sb "#FF0000" -i -l 5'
alias syu='sudo pacman -Syu'
alias xclip='xclip -sel clip'
alias watch="watch --color"

# True aliases
alias ..='cd ..'
alias py="python3"
alias python="python3"
alias pip="pip3"
alias markdown='markdown_py'
alias bc='calc'
alias uniq='sort -u'
alias table='column'
alias spacesniff="pwd | du -hd 1 | sort -h"
alias pid="ps -aux | grep"
alias clcd='cd ~ && clear'
alias zipthisfolder='zip -r zipname *'
alias howmuchspaceisonmydrives='df -h'
alias vanenet='ping example.com'
alias weather='curl wttr.in'
alias bctl="bluetoothctl"
alias locate='locate -i'
alias nonet='firejail --net=none'
alias mnt='sudo mount /dev/sda1 /mnt'
alias umnt='sudo umount /mnt'
alias cal="cal --monday"

myprojects(){
	# Iterate through folders in ~/Projects
	for fold in `command ls ~/Projects`; do
		# Line #4 is the programming language tag
		line=$(cat ~/Projects/$fold/README.md | sed -n "4p" | tr -d "\n\`")
	   	echo -ne "\e[34m$line\e[0m "

		# Check if there's a remote "origin" on github
		github=`git -C "/home/n/Projects/$fold" remote get-url origin 2>/dev/null | grep github`
		if [[ -n "$github" ]]; then
			echo -ne "\e[32mG\e[0m "
		fi

		soft=`git -C "/home/n/Projects/$fold" remote get-url soft 2>/dev/null`
		if [[ -n "$soft" ]]; then
			echo -ne "\e[32mS\e[0m "
		fi

		# Show folder name
		echo -ne "\e[35m$fold\e[0m "

		# Line #3 is the short description
		cat ~/Projects/$fold/README.md | sed -n "3p" # | tr "\n" "@"

		# Latest commit
# 		git -C "/home/n/Projects/$fold" log --oneline | head -n1
   	done | tr -d "\`" | sort # | tr "@" "\n"
}
export -f myprojects # allows to be used with `watch`

mybranches(){
	for fold in `command ls ~/Projects`; do
		echo "$fold"
		git -C "/home/n/Projects/$fold" branch
	done
}


# Grep
alias lgrep='ls | grep'
alias hgrep="history | grep"
alias bgrep='cat ~/.bashrc | grep'
alias tgrep='grep -r todo .'

# Edit Common Files
alias vbash='vim ~/.bashrc && source ~/.bashrc'
alias vvimrc='vim ~/.vimrc'


#  ____                           
# / ___|  ___ _ __ ___  ___ _ __  
# \___ \ / __| '__/ _ \/ _ \ '_ \ 
#  ___) | (__| | |  __/  __/ | | |
# |____/ \___|_|  \___|\___|_| |_|
                                
# Xrandr
secondMonitorName(){
	xrandr | grep HDMI | sed -e '/HDMI/!d' -e 's/\([^ ]\) .*/\1/'
}
mainMonitorName(){
	xrandr | grep eDP | sed -e '/eDP/!d' -e 's/\([^ ]\) .*/\1/'
}
xrotate(){
	echo -e "normal\nright\nleft" | dmenu |
	xargs xrandr --output $(secondMonitorName) --rotate
}
xposition(){
	xrandr --auto
	xrandr --auto --output $(secondMonitorName)  --$(echo -e "left\nright" | dmenu)-of $(mainMonitorName)
}
alias brightness='xrandr --output eDP-1 --brightness' # note: brightnessctl
alias redshift='echo -e "3000\n7000" | dmenu | xargs redshift -P -O'

# Switch GPU
gamermode(){
	if [ $1 == on ]; then
		optimus-manager --switch nvidia
	elif [ $1 == off ]; then
		optimus-manager --switch integrated
	fi
}




# Copy these to clipboard
alias lenny="echo -n '( ͡° ͜ʖ ͡°)' | xclip -sel clip && echo 'Lenny face on clipboard!'"
alias shrug="echo -n '¯\_(ツ)_/¯' | xclip -sel clip && echo 'Shrug face on clipboard!'"

# Ranger (cd to exit position)
ranger_cd() {
	# Copied from: /usr/share/doc/ranger/examples/shell_automatic_cd.sh
	temp_file="$(mktemp -t "ranger_cd.XXXXXXXXXX")"
	ranger --choosedir="$temp_file" -- "${@:-$PWD}"
	if chosen_dir="$(cat -- "$temp_file")" && [ -n "$chosen_dir" ] && [ "$chosen_dir" != "$PWD" ]; then
		cd -- "$chosen_dir"
	fi
	rm -f -- "$temp_file"
}
alias ranger="ranger_cd"

# Git
alias ga="git add ."
alias gc="git commit -m"
alias gac="git add . && git commit -m"
alias gs="git status"
alias gd="git diff"
alias gdc="git diff --cached"
alias amend="git commit --amend"
alias gl="git log --oneline"
alias gla="gl --graph --all"
alias githublink='sed -e "s#https://github.com/#git@github.com:#" -e "s/^.*$/git remote set-url origin \0.git/"'

blame(){
	filename=$1
	# Yeah, we're turning the git log into one large sed command
	gensed=`git log --oneline | sed -e 's/\([^ ]*\) \(.*\)/-e "s@\1[^)]*@\2@"/' | tr "\ " " "`
	git blame -s $filename | eval sed $gensed | $PAGER

}

#  _____         _                             _            
# |_   _|_ _ ___| | ____      ____ _ _ __ _ __(_) ___  _ __ 
#   | |/ _` / __| |/ /\ \ /\ / / _` | '__| '__| |/ _ \| '__|
#   | | (_| \__ \   <  \ V  V / (_| | |  | |  | | (_) | |   
#   |_|\__,_|___/_|\_\  \_/\_/ \__,_|_|  |_|  |_|\___/|_|   

alias td="task add"
alias tdb='td priority:L'
alias tp='td pro:$(t _unique project | dmenu)'
alias tbp='tdb pro:$(t _unique project | dmenu)'
alias tpb='tdb pro:$(t _unique project | dmenu)'
alias tt='td pro:inbox'
alias tmr='task modify wait:tomorrow'
alias subtask='task $(task +LATEST uuids) annotate subtask: '
alias tasknocontext='task rc.context:none'
alias backlog="task rc.context=backlog"
alias tw='timew'




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
[[ -z `echo "$PROMPT_COMMAND" | grep promptc` ]] && PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ;} promptc" 
