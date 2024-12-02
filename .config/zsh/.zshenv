#### .zshenv - Set Environment Variables ####

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

### Platform Enumeration ###
export PLATFORM_MACOS_ARM="macos-arm"
export PLATFORM_LINUX="linux"

PLATFORM=""

if [[ "$(uname)" == "Darwin" && "$(uname -p)" == "arm" ]]; then
	export PLATFORM="${PLATFORM_MACOS_ARM}"
else
	export PLATFORM="${PLATFORM_LINUX}"
fi

### PATH ###
# TODO: case matching, handle default
if [[ "${PLATFORM}" == "${PLATFORM_MACOS_ARM}" ]]; then
	export PATH="/opt/homebrew/bin:${PATH}"  # For Apple Silicon Macs
fi

### XDG Base Directory Specification ###
# See https://wiki.archlinux.org/title/XDG_Base_Directory
if [[ "${PLATFORM}" == "${PLATFORM_MACOS_ARM}" ]]; then
	export XDG_CACHE_HOME="${HOME}/Library/Caches/XDG-Cache"
	#ln -s "${XDG_CACHE_HOME}" "${HOME}/.cache"
elif [[ "${PLATFORM}" == "${PLATFORM_LINUX}" ]]; then
	export XDG_CACHE_HOME="${HOME}/.cache"
fi
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"

### ZSH / oh-my-zsh ###
ZSH_CACHE="${XDG_CACHE_HOME}/zsh"
ZSH_COMPDUMP="${ZDOTDIR}/.zcompdump-lambda"  # TODO: make generic

### Editor ###
if type "nvim" > /dev/null; then
	export EDITOR=nvim
elif type "vim" > /dev/null; then
	export EDITOR=vim
else
	export EDITOR=vi
fi

### Golang ###
#export GOPATH="${XDG_CONFIG_HOME}/go"
#export GOMODCACHE="${XDG_CACHE_HOME}/go/mod"

### Other ###
#export RIPGREP_CONFIG_HOME="${XDG_CONFIG_HOME}/ripgrep/config"

#export WGETRC="${XDG_CONFIG_HOME}/wgetrc"

#export GNUPGHOME="${XDG_DATA_HOME}/gnupg"
