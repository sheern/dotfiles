#!/bin/sh
dotfiles=`realpath ~/dotfiles`

# Create/update symlink for ~/.zshrc
ln -fs $dotfiles/.zshrc ~/.zshrc
