ZSHRC=$HOME/.zshrc
DOTFILES=$(dirname $(if [ -h $ZSHRC ]; then dirname $(readlink "$ZSHRC"); else $(cd "$(dirname "$ZSHRC")" ; pwd -P); fi))

source "$DOTFILES/zsh/antigen/antigen.zsh"

antigen use oh-my-zsh
antigen bundle zsh-users/zsh-syntax-highlighting

SAVEHIST=1000000
unsetopt share_history

export REPORTTIME=1

if [ -d $HOME/.zshrc.d ]; then
    for file in $HOME/.zshrc.d/*.zsh(N); do
        source $file
    done
fi

antigen apply

autoload -U bashcompinit
bashcompinit
