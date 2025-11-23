#!/usr/bin/env zsh
# This file is always sourced

export EDITOR='nvim'
export TERMINAL='alacritty'

eval $(dircolors) # Set LS_COLORS for use in e.g. zsh completion menu
export MANPAGER="sh -c 'awk '\''{ gsub(/\x1B\[[0-9;]*m/, \"\", \$0); gsub(/.\x08/, \"\", \$0); print }'\'' | bat -p -lman'" # man-db
# export MANPAGER='less --use-color -Dd+r -Du+b' # mandoc
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_DEFAULT_OPTS="
	--color=fg:#908caa,bg:#191724,hl:#ebbcba
	--color=fg+:#e0def4,bg+:#26233a,hl+:#ebbcba
	--color=border:#403d52,header:#31748f,gutter:#191724
	--color=spinner:#f6c177,info:#9ccfd8
	--color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"
export GTK_THEME=Adwaita:dark
export GTK2_RC_FILE=/usr/share/themes/Adwaita-dark/gtk-2.0/gtkrc
export QT_STYLE_OVERRIDE=Adwaita-Dark

# Paths
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export GOPROXY="direct"
export GOPATH="$XDG_DATA_HOME/go"
export GOBIN="$HOME/.local/bin"
export PYTHON_HISTORY=$XDG_STATE_HOME/python_history
export LESSHISTFILE=$XDG_STATE_HOME/less_history
export JUPYTER_CONFIG_DIR=$XDG_CONFIG_HOME/jupyter
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc

export PATH="$PATH:$HOME/.local/bin:$HOME/.local/bin/scripts"

# Custom scripts
export CHEATS_DIRECTORY="$HOME/Notes/Software/Cheat-sheets"

if [[ $(uname) = "Darwin" ]]; then
    export HOMEBREW_NO_EMOJI=1
    export HOMEBREW_NO_AUTO_UPDATE=1
    eval "$(/opt/homebrew/bin/brew shellenv)"
    export PATH="$PATH/opt/local/bin:/opt/local/sbin"
fi
