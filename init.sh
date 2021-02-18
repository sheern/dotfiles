#!/bin/bash
dotfiles="$HOME/dotfiles"

# Clone the plugins
cd $dotfiles
echo "Updating submodules for zsh plugins"
git submodule update --init

# Install important packages
cat $dotfiles/packages_to_install.txt | xargs sudo apt install

# Install oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "Already have oh-my-zsh, skipping install"
fi

# Vundle (plugin manager for vim)
vundle="$HOME/.vim/bundle/Vundle.vim"
if [ ! -d $vundle ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git $vundle
else
    echo "Vundle already exists, skipping clone"
fi

configs=('.zshrc' '.vimrc' '.tmux.conf')
# Create/update symlinks
for config in ${configs[@]}; do
    echo "Linking $config"
    ln -fs $dotfiles/$config ~/$config
done

echo "Restart shell for changes to take effect"
