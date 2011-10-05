run_scripts()
{
    for script in $1/*; do
        # skip non-executable snippets
        [ -x "$script" ] || continue

        #execute $script in the context of the current shell
        . $script
    done
}

load_bashrc()
{
    run_scripts "${HOME}/.bashrc.d"
}

load_bashrc

# Git aliases
alias gc='git commit -v'
alias gca='git commit -a -v'
alias gd='git diff'
alias gl='git pull'
alias glod='git log --oneline --decorate'
alias gp='git push'
alias gpr='git pull --rebase'
alias gst='git status'
