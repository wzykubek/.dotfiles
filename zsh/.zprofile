export EDITOR='nvim'
export HOMEBREW_NO_EMOJI=1
export HOMEBREW_NO_AUTO_UPDATE=1
export FZF_DEFAULT_COMMAND='fd --type f'

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export ZDOTDIR=$XDG_CONFIG_HOME/zsh
export GOPROXY="direct"
export GOPATH="$XDG_DATA_HOME/go"
export GOBIN="$HOME/.local/bin"
export PYTHON_HISTORY=$XDG_STATE_HOME/python_history
export LESSHISTFILE=$XDG_STATE_HOME/less_history
export JUPYTER_CONFIG_DIR=$XDG_CONFIG_HOME/jupyter

export PATH="$PATH:$HOME/.local/bin:$HOME/.local/bin/scripts"

if [[ $(uname) = "Darwin" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
    export PATH="$PATH/opt/local/bin:/opt/local/sbin"
fi

