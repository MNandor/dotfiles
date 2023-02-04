# Dotfiles

My personal customization files.
`linux`

## Installation (for myself)

Install with ssh right away so it's easier to update on Github.
Upload the ssh key right away, then clone from `~`.

```bash
ssh-keygen -t ed25519
git clone git@github.com:MNandor/dotfiles.git
cd dotfiles
```

GNU Stow doesn't like to overwrite existing files. As a workaround:

```bash
stow --adopt --target=$HOME .
git restore .
```

