
# My dotfiles

A repo for my dotfiles that I want to keep safe.

## Installation
The dotfiles are inteded to be used with GNU stow for easy management but can of course be copied into their directories manually.

**Using GNU stow:**

Install GNU stow with your package manager of choice:
```
$ sudo pacman -S stow
or
$ brew install stow
etc...
```

Clone the repo and cd into it:
```
$ git clone https://github.com/Zwoooz/dotfiles.git
$ cd dotfiles
```

Use stow to make symlinks for the dotfiles you want to use.

For example:
```
$ stow -t ~ nvim zshrc fastfetch
```
If you cloned the repo directly to your home directory you can exclude the `-t` flag as stow will automatically place the symlinks in the parent directory

**Done!**

Keep in mind that if you had previous dotfiles with the same directory and name where stow is trying to create symlinks they will need to be removed (or preferably backed up) for stow to be able to work. As stow will not replace any files.