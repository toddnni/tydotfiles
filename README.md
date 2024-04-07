Toni's .dotfiles
---------------

Contains only the minimal essential editor and shell configs. The ones that are needed on nearly every host.
No application configs.

Notes for bootstrapping
-----------------------

The preferred set of shell applications

    sudo apt-get install curl git tig ranger vim vim-fugitive vim-editorconfig zsh zsh-syntax-highlighting

Change the shell

    sudo chsh -s "$(command -v zsh)" "$(id -u -n)"

Git config

    git config --global user.name "xxxx yyyy"
    git config --global user.email xxxx.yyyy@example.com

License
-------

The config files or parts of them can be freely used. See `LICENSE` file

Vim plugins or ZSH plugins in `.zsh-partial-imports/` are copied from elsewhere and different licenses apply to them.
