eval "$(starship init zsh)"
# fast launch of   powerlevel10k
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi


# zinit plugin manager installation and configuration 
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"


# installing plugins
# zinit ice noclear depth=1; zinit light romkatv/powerlevel10k
zinit ice noclear depth=1; zinit light zsh-users/zsh-syntax-highlighting
zinit ice noclear depth=1; zinit light zsh-users/zsh-completions; autoload -U compinit && compinit
zinit ice noclear depth=1; zinit light zsh-users/zsh-autosuggestions
zinit ice noclear depth=1; zinit light Aloxaf/fzf-tab


# Add in snippets        
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/<plugin_name>
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::python


# Completions
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors '${(s.:.)LS_COLORS}'
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:*' fzf-preview \
  '([[ -f $realpath ]] && (command -v bat &>/dev/null && bat --style=plain --color=always $realpath || (file $realpath; head -n 10 $realpath)) || ls --color $realpath)'

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
export HIST_IGNORE_PATTERN="^(clear|ls|pwd)$"
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups


# Keybindings 
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line



# Aliases
if command -v exa> /dev/null; then # replacing ls to exa
    alias ls='exa'
    alias ll='exa -alh'
    alias tree='exa --tree'
else
    alias ls='ls'
    alias ll='ls -alh'
    alias tree='tree'
fi


if command -v bat> /dev/null; then # replacing bat to cat
    alias cat='bat'
else
fi

alias fzf='fzf --tmux center'
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

#temp aliases
alias icat='kitty icat'
alias tmuxn='tmux new -s'
alias wli="wl-paste --type image/png | kitty +kitten icat --stdin=yes"

export VISUAL=nvim
export PYTHON_VENV_NAME=.venv    # ohmyzsh plugin python
export PYTHON_AUTO_VRUN=true     # ohmyzsh plugin python
