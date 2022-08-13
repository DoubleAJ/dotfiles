# Personal Dotfiles

This repo can be checked out directly in the home directory.

#### Terminal Emulator - Alacritty

Goes in **\~/.config/alacritty/alacritty.yml**

#### Shell - Zsh

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

#### NeoVim

No self-made config for this. Checkout this configuration, complete with plugins in *\~/.config/nvim* :

<https://github.com/LunarVim/nvim-basic-ide>

Note that the following language server binaries, and other packages must be installed on the system:

* clangd
* pyright
* rust_analyzer
* lua-language-server
* yaml-language-server
* npm (for pulling plugins for other languages)