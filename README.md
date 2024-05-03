Toni's .dotfiles
---------------

Contains only the minimal essential editor and shell configs. The ones that are needed on nearly every host.
No application configs.

These are also used as devcontainer dotfiles.

Notes for bootstrapping
-----------------------

This repo files

    mkdir -p ~/.vim/swp
    sh install.sh

The preferred set of shell applications

    sudo apt-get install curl git tig ranger vim vim-fugitive vim-editorconfig zsh zsh-syntax-highlighting tmux
    sudo apt-get install libenchant-2-voikko voikko-fi

Change the shell

    sudo chsh -s "$(command -v zsh)" "$(id -u -n)"

Git config

    git config --global user.name "xxxx yyyy"
    git config --global user.email xxxx.yyyy@example.com

License
-------

The config files or parts of them can be freely used. See `LICENSE` file

Vim plugins or ZSH plugins in `.zsh-partial-imports/` are imported from elsewhere and different licenses apply to them.
Tmux in `.tmux/partial-plugins/` are imported from elsewhere and different licenses apply to them.
