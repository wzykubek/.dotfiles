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

export ZPLUG_HOME=~/.zplug
source $ZPLUG_HOME/init.zsh

zplug "jeffreytse/zsh-vi-mode"
zplug "Aloxaf/fzf-tab"
zplug "zsh-users/zsh-syntax-highlighting", defer:2

if ! zplug check; then
  zplug install
fi

zplug load

alias -- cat=bat
alias -- diff='diff --color=auto'
alias -- grep='grep --color=auto'
alias -- ip='ip -color=auto'
alias -- less='bat --paging=always'
alias -- ls='eza --hyperlink --git --icons=auto'
alias -- sudo='sudo '
alias -- tmux=zellij
alias -- vim=nvim
alias -- vi=nvim

alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'
alias -g -- -h='--help 2>&1 | bat --language=help --style=plain'

zstyle ':completion:*' menu no
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'

if [[ $TERM != "dumb" ]]; then
  eval "$(starship init zsh)"
fi

eval "$(zoxide init zsh --cmd cd)"

eval "$(gpgconf --launch gpg-agent)"
export GPG_TTY=$(tty)
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
