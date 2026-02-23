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
