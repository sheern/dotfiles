# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Dotfiles shortcut
export DOTFILES=$HOME/dotfiles
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
# Use dotfiles custom dir
export ZSH_CUSTOM=$HOME/dotfiles/zsh_custom

# Theme and colors
ZSH_THEME="common"
type dircolors &>/dev/null && eval $(dircolors -b $DOTFILES/.dircolors) || echo "dircolors unavailable"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# How long should zsh wait for additional characters in a sequence
KEYTIMEOUT=1

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

# Preferred editor for local and remote sessions
export EDITOR='vim'

# List directory contents when navigating
chpwd() {
    la
}

# Command-line editing in vim mode
bindkey -v
# Visual mode opens vim buffer
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

export FZF_DEFAULT_COMMAND='rg --files --hidden'
export FZF_CTRL_T_COMMAND='rg --files --hidden'
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'
# fzf shell key-bindings
source /usr/share/doc/fzf/examples/key-bindings.zsh

