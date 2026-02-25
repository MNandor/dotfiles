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

	echo running wrapper
    echo git "$cmd" "${args[@]}" "${paths[@]}"
    command git "$cmd" "${args[@]}" "${paths[@]}"
}
