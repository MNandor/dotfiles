# Dotfiles

My personal customization files.
`linux`

I re-organized this repo in late 2025 when I actually started having a reason to access my configuration on different computers.
If you're seeing this, you're in the new version.
The name of the branch should either be `public` or be something based on `public`.

## Cloning

If you install with ssh right away (as opposed to https), you will have an easier time pushing updates.
Generate, upload the public key, clone.

```bash
ssh-keygen -t ed25519
git clone git@github.com:MNandor/dotfiles.git
cd dotfiles
```

## Worktrees

You will likely want a local tree so you don't always have to rebase the changes that only belong on one computer.

```bash
git worktree add ../dotfiles-local -b local
cd ../dotfiles-local
stow --adopt --target=$HOME .
```

## Stow

GNU Stow doesn't like to overwrite existing files. As a workaround:

```bash
stow --adopt --target=$HOME .
git restore .
```

# Git Log is the Documentation

I try to make each commit as small and topical as possible.
Just `git blame` each file to find out *why* I added a particular change.

Commits do not have any tagging like "[bashrc] added aliases".
Instead, most commits change only one file, so you can filter out irrelevant commits with `git log .bashrc`.

## Workflow

Note to self: when you start with a new file, first make a commit that just adds the default unconfigured config file (whatever comes default with your OS at the time) and make modifications to it. Done so with qtile and .bashrc already.

## On rebasing

Since your local worktree depends on public, and public will receive changes, you frequently want to rebase onto public.
You might also make a commit to the local tree and later decide it belongs on public. So you cherry-pick from public, then rebase local onto public.

In both cases, check using `git diff` that you didn't lose any changes to merge conflicts.
