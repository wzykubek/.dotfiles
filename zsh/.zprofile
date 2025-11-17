export HOMEBREW_NO_EMOJI=1
export HOMEBREW_NO_AUTO_UPDATE=1

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

export PATH="$PATH:$HOME/.local/bin"

if [[ $(uname) = "Darwin" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

##
# Your previous /Users/wzykubek/.zprofile file was backed up as /Users/wzykubek/.zprofile.macports-saved_2025-11-17_at_01:12:16
##

# MacPorts Installer addition on 2025-11-17_at_01:12:16: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

