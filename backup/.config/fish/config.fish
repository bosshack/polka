set -x TERM=xterm-256color
set -x EDITOR=vim

if status --is-login
  for p in /usr/bin /usr/local/bin /opt/local/ ~/bin $HOME/.rbenv/bin $HOME/.rbenv/shims
    if test -d $p
      set PATH $p $PATH
    end
  end
end

set fish_greeting ""

function __in_git_working_tree
  git rev-parse --is-inside-work-tree >/dev/null ^&1
end

function __git_current_head
  git symbolic-ref HEAD ^ /dev/null
  or git describe --contains --all HEAD
end

function __git_current_branch
  __git_current_head | sed -e "s#^refs/heads/##"
end

function __git_working_tree_status
  git status --porcelain | __format_git_working_tree | sort -u | tr -d '\n'
end

function __format_git_working_tree
  set m (set_color yellow)'*'(set_color normal)
  set d (set_color red)'-'(set_color normal)
  set a (set_color green)'+'(set_color normal)
  sed -e "s/^.\(.\).*/\1/" -e "s/M/$m/" -e "s/D/$d/" -e "s/?/$a/"
end

function fish_prompt -d "Write out the prompt"
  printf '%s%s@%s%s ' (set_color yellow) (whoami) (hostname|cut -d . -f 1) (set_color normal)

  # Color writeable dirs green, read-only dirs red
  if test -w "."
    printf '%s%s%s' (set_color green) (prompt_pwd) (set_color normal)
  else
    printf '%s%s%s' (set_color red) (prompt_pwd) (set_color normal)
  end

  # Print git branch
  if __in_git_working_tree
    printf '%s %s%s%s %s' (set_color normal) (set_color blue) (__git_current_branch) (set_color normal) (__git_working_tree_status)
  end

  printf '%s\n❯ ' (set_color normal)
end

rbenv rehash >/dev/null ^&1

function rtags
  rdoc -f tags app lib vendor config $argv
end

function be
  bundle exec "$argv"
end
