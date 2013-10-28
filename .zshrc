autoload -U colors; colors
autoload -U promptinit; promptinit
autoload -U compinit; compinit

setopt completealiases

typeset -U path

# paths are for winners
path=(
  ${HOME}/.rubies/bin
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

# git prompt, yo
git_prompt_info () {
  local g="$(git rev-parse --git-dir 2>/dev/null)"
  if [ -n "$g" ]; then
    local r
    local b
    local d
    local s
    # Rebasing
    if [ -d "$g/rebase-apply" ] ; then
      if test -f "$g/rebase-apply/rebasing" ; then
        r="|REBASE"
      fi
      b="$(git symbolic-ref HEAD 2>/dev/null)"
    # Interactive rebase
    elif [ -f "$g/rebase-merge/interactive" ] ; then
      r="|REBASE-i"
      b="$(cat "$g/rebase-merge/head-name")"
    # Merging
    elif [ -f "$g/MERGE_HEAD" ] ; then
      r="|MERGING"
      b="$(git symbolic-ref HEAD 2>/dev/null)"
    else
      if [ -f "$g/BISECT_LOG" ] ; then
        r="|BISECTING"
      fi
      if ! b="$(git symbolic-ref HEAD 2>/dev/null)" ; then
        if ! b="$(git describe --exact-match HEAD 2>/dev/null)" ; then
          b="$(cut -c1-7 "$g/HEAD")..."
        fi
      fi
    fi

    # Dirty Branch
    local newfile='?? '
    if [ -n "$ZSH_VERSION" ]; then
      newfile='\?\? '
    fi
    d=''
    s=$(git status --porcelain 2> /dev/null)
    [[ $s =~ "$newfile" ]] && d+="+"
    [[ $s =~ "M " ]] && d+="*"
    [[ $s =~ "D " ]] && d+="-"

    if [ -n "${1-}" ]; then
      printf "$1" "${b##refs/heads/}${r}${d}"
    else
      printf "(%s) " "${b##refs/heads/}${r}${d}"
    fi
  fi
}

# set yo rubies son
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile

# use fasd
eval "$(fasd --init posix-alias zsh-hook zsh-ccomp)"

# use emacs bindings
bindkey -e

export PS1="%{$fg[green]%}%n%{$reset_color%} %{$fg[cyan]%}%~ $(ruby --version | awk '{print $2}')%{$reset_color%} $(git_prompt_info)
❯ "
