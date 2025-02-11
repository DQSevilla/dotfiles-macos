# Dotfiles

These are dotfiles managed by [GNU Stow](https://www.gnu.org/software/stow/) and primarily used on my personal Arch Linux install.

## Adding a New Configuration File

Add a new file to this repository in the correct directory, and run `stow .` at the git root.

## Deleting a Configuration File From The System

Run `stow -D .` to remove all managed files, or provide a specific path to remove just one.

## TODOs

- install script or nix
