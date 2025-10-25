#### Shell Aliases ####

### Single-Character ###
alias e="${EDITOR}"

### Zsh Config ###
alias zource="exec zsh"

### Update ###
alias update="brew update && brew upgrade & antidote update"

### Common Editing ###
alias ezsh="e ${ZDOTDIR}"
alias ezshrc="e ${ZDOTDIR}/.zshrc"
alias ezplugin="e ${ZDOTDIR}/.zsh_plugins.txt"
alias etrc="e ${XDG_CONFIG_HOME}/wezterm/*.lua"
alias arc="e ${ZDOTDIR}/aliases.zsh"
alias erc="cd ${XDG_CONFIG_HOME}/nvim && e ${XDG_CONFIG_HOME}/nvim"

_efd() {
  fd "${@}" -X "${EDITOR}"
}
cmd fd && alias efd="_efd"

### Common Dirs ###
alias dev="cd ${HOME}/src/dev"

### ls ###
alias ls="ls -F --color=tty"
alias la="ls -A"
alias ll="ls -lh"
alias lla="la -lah"
alias lal="lla"

### git ###
alias gst="git status"
alias gco="git checkout"
alias ga="git add"
alias gcm="git commit"
alias gb="git branch"
_gdab() {
  git fetch -p && git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -D
}
alias gdab="_gdab"

_update() {
  brew update && brew upgrade
  antidote update --all
}
alias update="_update"
