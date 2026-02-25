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

    # Only provide hash completion if the previous word was "show"
    if [[ "$prev" == "show" ]] && [[ -f /tmp/git_last_hashes ]]; then
        COMPREPLY=( $(compgen -W "$(cat /tmp/git_last_hashes)" -- "$cur") )
    fi
}

# Apply to the standard git command
complete -F _complete_git_hashes git
