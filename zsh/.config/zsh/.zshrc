# History {{{
HISTSIZE="10000"
SAVEHIST="10000"
HISTORY_IGNORE='(rm *|pkill *|cp *)'
HISTFILE="$XDG_STATE_HOME/zsh_history"
mkdir -p "$(dirname "$HISTFILE")"

setopt HIST_FCNTL_LOCK
unsetopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
unsetopt HIST_SAVE_NO_DUPS
unsetopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
unsetopt HIST_EXPIRE_DUPS_FIRST
setopt SHARE_HISTORY
unsetopt EXTENDED_HISTORY
# }}}

# Prompt {{{
export SUDO_PROMPT="$(printf '\033[1;31m')[sudo]$(printf '\033[0m') %p: "

if [[ $TERM != "dumb" ]]; then
  eval "$(starship init zsh)"
fi
# }}}

# Aliases {{{
alias -- sudo='sudo '
alias -- cat=bat
alias -- diff='diff --color=auto'
alias -- grep='grep --color=auto'
alias -- ip='ip -color=auto'
alias -- less='bat --paging=always'
alias -- ls='eza --hyperlink --git --icons=auto'
alias -- tree='eza --tree --hyperlink --git --icons=auto'
alias -- vim=nvim
alias -- vi=nvim

alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'
alias -g -- -h='--help 2>&1 | bat --language=help --style=plain'

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
# }}}

# Plugins {{{
function zvm_config() {
    ZVM_INIT_MODE=sourcing # Fix for fzf plugin
    ZVM_SYSTEM_CLIPBOARD_ENABLED=true
}

if [[ $(uname) = "Linux" ]]; then
    source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [[ $(uname) = "Darwin" ]]; then
    # TODO
fi

source <(fzf --zsh)
eval "$(zoxide init zsh --cmd cd)"
# }}}

# Completion {{{
fpath+=("$XDG_DATA_HOME/zsh/completions")
autoload -U compinit && compinit -d "$XDG_CACHE_HOME/zsh_zcompinit"
zstyle ':completion:*' menu select
zstyle ':completion:*:descriptions' format '[%d]'

export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --icons=auto --color=always {} | head -200'"

# Use fd for listing path candidates.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

_fzf_complete_paru() {
    if [[ "$@" == "paru -S"* ]]; then
        _fzf_complete --multi --preview "paru -Si {1}" -- "$@" < <(paru -Slq)
    fi
}

_fzf_complete_docker() {
    if [[ "$@" == "docker exec"* ]]; then
        _fzf_complete --preview "docker container logs {1} | tail" -- "$@" < <(
            docker container ls --format "table {{ .ID }}\t{{ .Image }}\t{{ .Names }}"
        )
    fi
}

_fzf_complete_docker_post() {
  awk '{print $1}'
}

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview \
                    'eza --tree --icons=auto --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview \
                    "eval 'echo \$'{}" "$@" ;;
    ssh)          fzf --preview \
                    'dig {}' "$@" ;;
    *)            fzf --multi "$@" ;;
  esac
}
# }}}

# Bindings {{{
# Search history for specific command
bindkey "^p" up-line-or-search
bindkey "^[OA" up-line-or-search
bindkey "^[[A" up-line-or-search
bindkey "^n" down-line-or-search
bindkey "^[OB" down-line-or-search
bindkey "^[[B" down-line-or-search

# Shift+tab in completion menu
# bindkey '^[[Z' reverse-menu-complete
# }}}

# Other {{{
eval "$(gpgconf --launch gpg-agent)"
export GPG_TTY=$(tty)
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
# }}}
