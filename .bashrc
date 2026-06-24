#
# ~/.bashrc
#
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
export EDITOR="vim"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Single-letter shortcuts
# alias g="git" # see .bash_git.sh
alias p="python3"
alias r="ranger"
alias t="task"
alias v="vim"
# w = (show logged in users, not an alias)
alias x="xdg-open"
alias open="xdg-open"

alias td="task add"


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

# True aliases
alias ..='cd ..'
alias ...='cd ../..'
alias py="python3"
alias python="python3"
alias pip="pip3"
alias bc='calc'
alias table='column'
alias clcd='cd ~ && clear'
alias zipthisfolder='zip -r zipname *'
alias howmuchspaceisonmydrives='df -h'
alias howmuchspaceisonmybtrfs='sudo btrfs fi df /'
alias vanenet='watch ping -c 1 example.com'
alias weather='curl wttr.in'
alias bctl="bluetoothctl"
alias locate='locate -i'
alias mnt='sudo mount /dev/sda1 /mnt'
alias umnt='sudo umount /mnt'
alias cal="cal --monday"
alias hgrep="history | grep"

# Edit Common Files
alias vbash='vim ~/.bashrc && source ~/.bashrc'
alias vvimrc='vim ~/.vimrc'
alias vqtile='vim ~/.config/qtile/config.py'


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

# Aliases are evaluated at execution time, meaning it doesn't matter when
# .bash_git.sh is sourced. The important part is that it has g(), which is
# a wrapper around git commands. Note that you can still call `git` normally.
#
# If you change to `alias G=git`, you get normal functionality in all these aliases
# Define aliases with `G` if you want the wrapper's functionality, `git` otherwise
#
# The wrapper does things like expanding files after -- to **/Filename.* for easy matching
# It also populates the bash autocomplete when calling `g log` (or `gl` variants) but not `git log`.
# More might be added later

alias G=g

alias ga="git add ."
alias gap="git add -p ."
# alias gc="git commit -m" # has function
alias gco="G checkout"
alias gce=gco
alias gcb="git checkout -b"
alias gb="git branch | fzf | xargs git checkout"
alias gac="git add . && git commit -m"
alias gs="git status"
alias gso="G show"
alias gsh="G show"
alias gw="git switch"
alias gd="G diff -w"
alias gdc="G diff -w --cached"
alias gdw="G diff --color-words"
alias gdcw="G diff --color-words --cached"
alias gds="G diff --stat"
alias gdwc=gdcw
alias amend="git commit --amend"
alias ammend="git commit --amend"
alias gl="G log --oneline"
alias gla="gl --graph --all"
alias gln="G log --oneline --name-only"
alias gmt="git mergetool"
alias grs="G restore"
alias grss="grs --staged"
alias grsc=grss
alias grc="git rebase --continue"
alias gitroot='cd $(git rev-parse --show-toplevel)'
alias githublink='sed -e "s#https://github.com/#git@github.com:#" -e "s/^.*$/git remote set-url origin \0.git/"'
alias gps="git pull --recurse-submodules"

codecomment(){
	figlet "$@" | sed 's#.*#// \0#' | xclip -sel clip
	echo "Copied to clipboard!"
}


pythoncomment(){
	figlet "$@" | sed 's/.*/# \0/' | xclip -sel clip
	echo "Copied to clipboard!"
}
alias pycomment=pythoncomment

# Up Arrow
bind '"\e[A": history-search-backward'
# Down Arrow
bind '"\e[B": history-search-forward'

[ -f ~/.bash_git.sh ] && source ~/.bash_git.sh
flameshotwindow() {
    # Prompt to click a window and get its geometry
    local info W H X Y

    info=$(xwininfo -stats)

    # Extract geometry
    W=$(echo "$info" | awk '/Width:/ {print $2}')
    H=$(echo "$info" | awk '/Height:/ {print $2}')
    X=$(echo "$info" | awk '/Absolute upper-left X:/ {print $4}')
    Y=$(echo "$info" | awk '/Absolute upper-left Y:/ {print $4}')

    # Launch Flameshot on the window region
    flameshot gui --region $W,$H,$X,$Y
}

alias flameshotagain="flameshot gui --last-region"

taskcurrentcontext(){
	[ -z "$1" ] && echo "Usage: taskcurrentcontext <definition>" && return 1
	yes | task context define current "$1" > /dev/null
	task context current
}

alias tiddly="tiddlywiki ~/Tiddly/ --listen"

# first argument: the file we look for has to reference the first argument.
# this is mostly for import statements
# note that the file that defines the symbol typically references itself at least in class name
# don't include .kt or .java in first argument
#
# second argument: the symbol to search for
findusages() {                                                                                                           
    rg -l "$1" --type kotlin --type java | xargs rg "$2" -C 5                                                              
  }       

alias kitty-green='kitty @ set-colors background="#1b2f1b"'
alias kitty-blue='kitty @ set-colors background="#1b2438"'
alias kitty-red='kitty @ set-colors background="#341b1b"'
alias kitty-purple='kitty @ set-colors background="#2b1b36"'
alias kitty-pink=kitty-purple
alias kitty-orange='kitty @ set-colors background="#352715"'
alias kitty-yellow=kitty-orange
alias kitty-reset='kitty @ load-config'

