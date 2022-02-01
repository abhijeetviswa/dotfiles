# Personal dotfiles

This my personal collection of dotfiles that are symlinked into machines that I use.
Most configurations assume the OS of choice is GNU/Linux, liberally using XDG config
variables. However, with some modifications, it should be usable on other \*NIXes

Configurations for the follow applications are present in this repo:
* Alacritty
* tmux
* vim
* zsh

## Plugin managers and other notes

Certain configs expect the existence of plugin managers or other external scripts.
They are notes here as follows:

* zsh expects [oh-my-zsh] and [powerlevel10k].
* tmux expects [tpm].
* vim expects [vim-plug].

[oh-my-zsh]: https://github.com/ohmyzsh/oh-my-zsh
[powerlevel10k]: https://github.com/romkatv/powerlevel10k
[tpm]: https://github.com/tmux-plugins/tpm
[vim-plug]: https://github.com/tmux-plugins/tpm

## Folder Mapping

Repo Directory | Final Directory
-------------- |  ---------------
`config/*` | `~/.config/*`
`vimrc` | `~/.vimrc`
`tmux.conf` | `~/.tmux.conf`
`zsh/zshrc` | `~/.zshrc`
`zsh/zshenv` | `~/.zshenv`

## Copyright
Copyright (c) Abhijeet V 2022

You MAY NOT reproduce, either partially or fully, this repository or it's content as your own. 
You may however draw inspiration from this repository for your personal dotfiles.
