autoload -U colors; colors
autoload -U promptinit; promptinit
autoload -U compinit; compinit

typeset -U path

path=(
  ${HOME}/.rvm/bin
  ${HOME}/bin
  $(brew --prefix)/bin
  /usr/bin
  /bin
  $(brew --prefix)/sbin
  /usr/sbin
  /sbin
  /usr/X11/bin
  $(brew --cellar)/python
)

export PS1="┌─[%{$fg[green]%}%n%{$reset_color%}]─[%{$fg[cyan]%}%~%{$reset_color%}]
└─> "
