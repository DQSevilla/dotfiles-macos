#### Shell Aliases ####

### Single-Character ###
alias e="${EDITOR}"

### Zsh Config ###
alias zource="exec zsh"

### Common Editing ###
alias ezsh="e ${ZDOTDIR}"
alias ezshrc="e ${ZDOTDIR}/.zshrc"
alias ezplugin="e ${ZDOTDIR}/.zsh_plugins.txt"
alias etrc="e ${XDG_CONFIG_HOME}/wezterm/*.lua"
alias arc="e ${ZDOTDIR}/aliases.zsh"
alias erc="e ${XDG_CONFIG_HOME}/nvim"

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
