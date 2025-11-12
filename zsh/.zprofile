export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export ZDOTDIR=$XDG_CONFIG_HOME/zsh
export GOPROXY="direct"
export GOPATH="$XDG_DATA_HOME/go"
export GOBIN="$HOME/.local/bin"

export PATH="$PATH:$HOME/.local/bin"

if [[ $(uname) = "Darwin" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
