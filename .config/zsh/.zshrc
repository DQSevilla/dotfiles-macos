# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#===============#
### Utilities ###
#===============#

# cmd returns 0 if a given command exists.
function cmd() {
	command -v "${1}" >/dev/null 2>&1
}

#=====================================#
### Essential Environment Variables ###
#=====================================#

# NOTE: Bootstrapped by "${HOME}/.zshenv" with the following contents:
#
# ```
# export XDG_CONFIG_HOME="${HOME}/.config"
# export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
#
# if [[ -f "${ZDOTDIR}/.zshenv" ]]; then
# 	source "${ZDOTDIR}/.zshenv"
# fi
# ```

# XDG Base Directory Specification
# See https://wiki.archlinux.org/title/XDG_Base_Directory
export XDG_CACHE_HOME="${HOME}/Library/Caches/XDG-Cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"

# Homebrew binary path for Apple Silicon Macs
export PATH="/opt/homebrew/bin:${PATH}"

# Editor
if cmd "nvim"; then
	export EDITOR=nvim
elif cmd "vim"; then
	export EDITOR=vim
else
	export EDITOR=vi
fi

# Zsh/antidote
export ZSH_CACHE="${XDG_CACHE_HOME}/zsh"
export ZSH_COMPDUMP="${ZDOTDIR}/.zcompdump-lambda"  # TODO: make generic

# Antidote Plugin Manager
[[ -f "${ZDOTDIR:-~}/.zsh_plugins.txt" ]] || touch "${ZDOTDIR:-~}/.zsh_plugins.txt"
source "$(brew --prefix)/opt/antidote/share/antidote/antidote.zsh"
antidote load

#=========================#
###  Zsh Configuration  ###
#=========================#

setopt autocd
setopt autopushd

# Comments allowed in interactive shell prompt
setopt interactivecomments

# Smarter substring search
bindkey -M viins '^[[A' history-substring-search-up
bindkey -M viins '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
bindkey -M vicmd '^P' history-substring-search-up
bindkey -M vicmd '^N' history-substring-search-down

if [[ -f "${ZDOTDIR}/aliases.zsh" ]]; then
	source "${ZDOTDIR}/aliases.zsh"
fi

#=========================#
### Tools Configuration ###
#=========================#

# Golang
cmd "go" && export GOPATH="${XDG_CONFIG_HOME}/go"
cmd "go" && export GOPATH="${XDG_CACHE_HOME}/go/mod"

# Python
cmd "uv" && eval "$(uv generate-shell-completion zsh)"

# Ripgrep
cmd "rg" && export RIPGREP_CONFIG_HOME="${XDG_CONFIG_HOME}/ripgrep/config"

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
