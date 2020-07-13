# Lines configured by zsh-newuser-install
HISTFILE=~/.cache/cli-histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/mushegh/.zshrc'

autoload -Uz compinit promptinit
compinit
promptinit

PROMPT="%~ > "
RPROMPT="%n@%m"
