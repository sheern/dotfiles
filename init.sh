#!/bin/bash
dotfiles=`realpath ~/dotfiles`

# Clone the plugins
cd $dotfiles
git submodule update --init

# Install oh-my-zsh
if [ -z $ZSH ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "Already have oh-my-zsh, skipping install"
fi

configs=('.zshrc' '.vimrc' '.tmux.conf')
# Create/update symlinks
for config in ${configs[@]}; do
    ln -fs $dotfiles/$config ~/$config
done

echo "Restart shell for changes to take effect"