gc() {
    # No arguments -> open editor
    if [[ $# -eq 0 ]]; then
        git commit
        return
    fi

    # If first argument begins with '-' -> pass through unchanged
    if [[ "$1" == -* ]]; then
        git commit "$@"
        return
    fi

    # Otherwise -> treat all args as a commit message
    git commit -m "$*"
    echo commit -m "$*"
}

# git wrapper
# auto expands files after --
# with **/ to allow searching in root and subfolders
# and adds extensions
#
# user can still type "*PartialFileName*" instead of FullFileName
# though in that case quotes are needed, otherwise bash expands the wildcard
g() {
    local cmd="$1"
    shift

    local args=()
    local paths=()
    local seen_double_dash=false

    for arg in "$@"; do
        if $seen_double_dash; then
            local prefix=""
            local base="$arg"

	suffix=""
	if [[ "$arg" != *.* ]]; then
	   suffix=".*"
	fi

	paths+=(":(glob,icase)**/${base}${suffix}")

        else
            args+=("$arg")
            if [[ "$arg" == "--" ]]; then
                seen_double_dash=true
            fi
        fi
    done

    echo git "$cmd" "${args[@]}" "${paths[@]}"
    command git "$cmd" "${args[@]}" "${paths[@]}"

	# Command was git log?
	# We might want to do git show, diff, or similar next
    # Save hashes
	# To be used in autocomplete
	if [[ "$cmd" == "log" ]]; then
        # Create a copy of args without '--oneline'
		# Otherwise --oneline will output commit messages to the temp file
		# Even if our format options say otherwise
		local scrape_args=()
        for a in "${args[@]}"; do
            [[ "$a" != "--oneline" ]] && scrape_args+=("$a")
        done

		echo "${scrape_args[@]}"
        
		# Output to temp file
        command git log -n 20 --pretty="format:%h" "${scrape_args[@]}" "${paths[@]}" > /tmp/git_last_hashes 2>/dev/null
    fi
}

_complete_git_hashes() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local prev="${COMP_WORDS[COMP_CWORD-1]}"

    # 1. Custom logic for "git show"
    if [[ "$prev" == "show" ]] && [[ -f /tmp/git_last_hashes ]]; then
        COMPREPLY=( $(compgen -W "$(cat /tmp/git_last_hashes)" -- "$cur") )
    else
        # 2. Default behavior: provide filename completion
        COMPREPLY=( $(compgen -f -- "$cur") )
    fi
}

# Apply with -o default to allow Bash to fall back to filenames
# if COMPREPLY is still empty.
complete -F _complete_git_hashes -o default git
complete -F _complete_git_hashes -o default g

thisisareferencecommit(){
	[[ -z "$1" ]] && echo "error, give name" && return
	git tag n-references/$1
}


demonstrate() {
    local file="${1:-file.txt}"
    
    tmux new-session -d \; \
      send-keys "watch cat $file" C-m \; \
      split-window -v -p 50 \; \
      send-keys "watch git diff --color=always $file" C-m \; \
      split-window -h -p 50 \; \
      send-keys "watch git diff --cached --color=always $file" C-m \; \
      select-pane -t 0 \; \
      split-window -h -p 66 \; \
      send-keys "watch git show :$file" C-m \; \
      split-window -h -p 50 \; \
      send-keys "watch git show HEAD:$file" C-m \; \
      select-pane -t 0 \; \
      attach-session
}

blamer() {
    commits=`git log --oneline $@ | sed 's/ .*//'`

    sel=0
    diff=''

    while true; do
        clear

        cur=0
        for commit in $commits; do
            if [ $cur == $sel ]; then
                echo -n '*'
            fi
            echo -n "$commit "
            cur=$(($cur + 1))
        done

        commt=`echo $commits | sed 's/[a-z]/\u\0/' | cut -d' ' -f $((sel + 1))`
        commtc=`echo $commits | wc -w`
        echo $commtc

        echo

        if [ -z "$diff" ]; then
            git --no-pager show $commt $@
        elif [ "$diff" == ':' ]; then
            git --no-pager show $commt:$@
        fi

        echo -e "\n$diff$commt - h/l to switch commit, d to toggle diff, q to quit"
        read -n 1 -s key
        if [ $key == 'l' ] && (( $sel < $commtc - 1 )); then
            sel=$(($sel + 1))
        fi
        if [ $key == 'h' ] && [ "$sel" -gt 0 ]; then
            sel=$(($sel - 1))
        fi
        if [ $key == 'd' ]; then
            if [ -z "$diff" ]; then
                diff=':'
            elif [ "$diff" == ':' ]; then
                diff=''
            fi
        fi
        if [ $key == 'q' ]; then
            break
        fi
    done
}
