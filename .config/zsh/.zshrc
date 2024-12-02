export DUMMY_ENV_VAR=1

function cmd() {
	command -v "${1}" >/dev/null 2>&1
}

alias ls="ls -F --color=tty"

if cmd "uv"; then
	eval "$(uv generate-shell-completion zsh)"
fi
