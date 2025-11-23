# Prompt {{{
command_not_found_handler() {
  printf "ahh shit, command not found\n\033[0;31m(╯'□ ')╯ ┻━┻\n"
	exit 127
}

# Source: https://git.dawidpotocki.com/dawid/biual/tree/.zshrc
[ "$(id -u)" = 0 ] && _IS_ROOT="1"
[ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ] && _IS_SSH="1"

setopt promptsubst

if [ -z "$_IS_SSH" ]; then
	_PROMPT_PRIMARY_COLOUR="magenta"
	_PROMPT_SECONDARY_COLOUR="cyan"
else
	_PROMPT_PRIMARY_COLOUR="cyan"
	_PROMPT_SECONDARY_COLOUR="magenta"
fi
[ -n "$_IS_ROOT" ] && _PROMPT_PRIMARY_COLOUR="red"

PROMPT='%B%F{$_PROMPT_PRIMARY_COLOUR}%n${_PROMPT_AT_COLOUR}@%F{$_PROMPT_PRIMARY_COLOUR}%m%f%b in %B%F{$_PROMPT_SECONDARY_COLOUR}%~%f%b$(git_status)$(lf_status)
%f%b%(?:$ :%F{red}$ )%f'

git_status() {
	ref="$(git symbolic-ref --quiet --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)"
	if [ $? -eq 0 ]; then
		printf " on %s" "%B%F{$_PROMPT_PRIMARY_COLOUR}${ref}%b%f"
		[[ $(git status --short 2>/dev/null | wc -l) -ne 0 ]] && printf "%s" "%F{yellow}*%f"
	fi
}

lf_status() {
	[ -n "$LF_LEVEL" ] && printf " %s" "%B%F{243}(lf$LF_LEVEL)%b%f";
}

export SUDO_PROMPT="$(printf '\033[1;31m')[sudo]$(printf '\033[0m') %p: "
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
# Insert custom completions scripts here, e.g. for manually installed apps
COMPLETIONSDIR="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/completions"
mkdir -p "$COMPLETIONSDIR"
fpath+=("$COMPLETIONSDIR")

COMPINITFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompinit"
mkdir -p "$(dirname "$COMPINITFILE")"
autoload -U compinit && compinit -d "$COMPINITFILE"

zmodload zsh/complist                                       # Required for vi bindings and LS_COLORS

# Cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompcache"

# Settings
setopt COMPLETE_ALIASES
_comp_options+=(globdots)                                   # Include hidden files
zstyle ':completion:*' completer _complete _approximate     # Complete typos, lower-case and partials
zstyle ':completion:*' menu select                          # Display selection menu
zstyle ':completion:*' complete-options true                # Fix for cd command
zstyle ':completion:*' list-dirs-first true
zstyle ':completion:*:matches' group 'yes'                
zstyle ':completion:*' group-name ''                        # Required for proper grouping of files/directories

# Colors
zstyle ':completion:*:*:*:*:descriptions' format '%F{blue}-- %d --%f'
zstyle ':completion:*:*:*:*:corrections' format '%F{red}-- %d --%f'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Bindings
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey '^[[Z' reverse-menu-complete                        # Shift+Tab

# fzf specific
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree -L 3 --icons=auto --color=always --group-directories-first {} | head -200'"

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
                    'eza --tree -L 3 --icons=auto --color=always --group-directories-first {} | head -200' "$@" ;;
    export|unset) fzf --preview \
                    "eval 'echo \$'{}" "$@" ;;
    ssh)          fzf --preview \
                    'dig {}' "$@" ;;
    *)            fzf --multi "$@" ;;
  esac
}
# }}}

# Aliases {{{
alias cat=bat
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias ip='ip -color=auto'
alias less='bat --paging=always'
alias ls='eza --hyperlink --git --icons=auto --group-directories-first'
alias sudo='sudo '
alias tree='eza --tree --hyperlink --git --icons=auto'
alias wget='wget --hsts-file="${XDG_CACHE_HOME}/wget-hsts"'
alias vi=nvim
alias vim=nvim

alias -g -- -h='--help 2>&1 | bat --language=help --style=plain'
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'

# Wrappers
# yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
function y-widget() { y && zle reset-prompt }
zle -N y-widget
bindkey "^y" y-widget
# }}}

# History {{{
HISTSIZE="10000"
SAVEHIST="10000"
HISTORY_IGNORE='(rm *|pkill *|cp *)'
HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history"
mkdir -p "$(dirname "$HISTFILE")"

setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

# Search history for specific command
bindkey "^p" up-line-or-search
bindkey "^[OA" up-line-or-search
bindkey "^[[A" up-line-or-search
bindkey "^n" down-line-or-search
bindkey "^[OB" down-line-or-search
bindkey "^[[B" down-line-or-search
# }}}
