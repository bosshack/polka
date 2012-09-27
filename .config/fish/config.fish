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

function parse_git_branch
  sh -c 'git branch --no-color 2> /dev/null' | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
end

function fish_prompt -d "Write out the prompt"
  printf '┌─[%s%s@%s%s]─[' (set_color yellow) (whoami) (hostname|cut -d . -f 1) (set_color normal)

  # Color writeable dirs green, read-only dirs red
  if test -w "."
    printf '%s%s%s]' (set_color green) (prompt_pwd) (set_color normal)
  else
    printf '%s%s%s]' (set_color red) (prompt_pwd) (set_color normal)
  end

        # Print subversion tag or branch
        if test -d ".svn"
          printf ' %s%s%s' (set_color normal) (set_color blue) (parse_svn_tag_or_branch)
        end

  # Print subversion revision
  if test -d ".svn"
    printf '%s%s@%s' (set_color normal) (set_color blue) (parse_svn_revision)
  end

  # Print git branch
  if test -d ".git"
    printf '%s─[%s%s%s]' (set_color normal) (set_color blue) (parse_git_branch) (set_color normal)
  end
  printf '%s\n└─> ' (set_color normal)
end

rbenv rehash >/dev/null ^&1

function rtags
  rdoc -f tags app lib vendor config $argv
end
