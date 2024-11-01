# Pokemons
#pokemon-colorscripts --no-title -s -r

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

source "${ZINIT_HOME}/zinit.zsh"
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

zinit light jeffreytse/zsh-vi-mode
bindkey -v
# TODO: take out all thing connected with window server protocol in local variables
# yanking in system clipboard override :3
zvm_vi_yank () {
	zvm_yank
	printf %s "${CUTBUFFER}" |  wl-copy -n
	zvm_exit_visual_mode
}

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::python

# Load completions
autoload -U compinit && compinit

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word
# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors '${(s.:.)LS_COLORS}'
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
#zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

export EDITOR=nvim
# Aliases
# replacing ls to exa
if command -v exa> /dev/null; then
    alias ls='exa'
    alias ll='exa -alh'
    alias tree='exa --tree'
else
    alias ls='ls'
    alias ll='ls -alh'
    alias tree='tree'
fi


if command -v bat> /dev/null; then
    alias cat='bat'
else

fi

alias fzf='fzf --tmux center'

eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

#temp aliases
alias nv='NVIM_APPNAME=nvim2 nvim'
alias icat='kitty icat'
alias tmuxn='tmux new -s'
alias wli="wl-paste --type image/png | kitty +kitten icat --stdin=yes"
