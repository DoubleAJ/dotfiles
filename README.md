# Personal Dotfiles

This repo can be checked out directly in the home directory, by doing the following:
```
git init .
git remote add -t \* -f origin https://github.com/DoubleAJ/dotfiles.git
git checkout main
```
### Terminal Emulator - Alacritty

Goes in **\~/.config/alacritty/alacritty.yml**

### Shell - Zsh

Config file goes in **\~/.zshrc**

Shell is changed by calling: *chsh -s $(which zsh)*

Plugin list (arch repo):

```
community/powerline 
    Statusline plugin for vim, and provides statuslines and prompts for several other
    applications, including zsh, bash, tmux, IPython, Awesome, i3 and Qtile
community/zsh-autosuggestions 
    Fish-like autosuggestions for zsh
community/zsh-completions 
    Additional completion definitions for Zsh
community/zsh-history-substring-search 
    ZSH port of Fish history search (up arrow)
community/zsh-syntax-highlighting 
    Fish shell like syntax highlighting for Zsh
```

Do not install package for **powerlevel10k** from the normal repo, get from AUR:

<https://aur.archlinux.org/packages/zsh-theme-powerlevel10k-git>

It will automatically launch a configuration wizard.

To activate other plugins, add line to **\~/.zshrc** e.g.:

*source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh*

### NeoVim

For now I am using the LunarVim configuration for NeoVim (see https://www.lunarvim.org/).

*.config/lvim/config.lua* contains some personal settings, like a couple more key bindings, and Rust configuration.

### Window Manager

**i3**, with **Rofi** launcher, **Polybar**, **Nitrogen** for wallpaper, **Picom** as compositor.
