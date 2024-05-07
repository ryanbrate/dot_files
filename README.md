various dot files and otherbits for getting tools up and running as wanted ...

# Other

## .bashrc and .zshrc additions

```
export PATH="~/bin:$PATH"

alias fF='cd ~;vim $(fzf); cd -'
alias ff='vim $(fzf)'
alias fd='cd $(dirname $(fzf))'

alias gitlog='git log --oneline --graph --all --decorate'
```

## ~/.gitconfig
```
[diff]
    tool = vimdiff
```
