#
export EDITOR=nvim

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

PATH="$HOME/.local/share/node_modules/bin:$PATH"
export npm_config_prefix=~/.local/share/node_modules

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
    --color=fg:#e5e9f0,bg:#2e3440,hl:#81a1c1
    --color=fg+:#e5e9f0,bg+:#3b4251,hl+:#81a1c1
    --color=info:#eacb8a,prompt:#bf6069,pointer:#b48dac
    --color=marker:#a3be8b,spinner:#b48dac,header:#a3be8b'
