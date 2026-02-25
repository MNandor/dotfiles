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

# Git
alias ga="git add ."
alias gap="git add -p ."
# alias gc="git commit -m" # has function
alias gco="git checkout"
alias gce=gco
alias gcb="git checkout -b"
alias gb="git branch | fzf | xargs git checkout"
alias gac="git add . && git commit -m"
alias gs="git status"
alias gso="git show"
alias gsh="git show"
alias gw="git switch"
alias gd="git diff -w"
alias gdc="git diff -w --cached"
alias gdw="git diff --color-words"
alias gdcw="git diff --color-words --cached"
alias gds="git diff --stat"
alias gdwc=gdcw
alias amend="git commit --amend"
alias ammend="git commit --amend"
alias gl="git log --oneline"
alias gla="gl --graph --all"
alias gln="git log --oneline --name-only"
alias gmt="git mergetool"
alias grs="git restore"
alias grss="grs --staged"
alias grsc=grss
alias grc="git rebase --continue"
alias gitroot='cd $(git rev-parse --show-toplevel)'
alias githublink='sed -e "s#https://github.com/#git@github.com:#" -e "s/^.*$/git remote set-url origin \0.git/"'
alias gps="git pull --recurse-submodules"

# Up Arrow
bind '"\e[A": history-search-backward'
# Down Arrow
bind '"\e[B": history-search-forward'

[ -f ~/.bash_git.sh ] && source ~/.bash_git.sh
