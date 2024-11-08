various dot files and otherbits for getting tools up and running as wanted ...

# Other

## .bashrc and .zshrc additions

```
export PATH="~/bin:$PATH"

alias fF='cd ~;vim $(fzf); cd -'
alias ff='vim $(fzf)'
alias fd='cd $(dirname $(fzf))'
```

## ~/.gitconfig
```
[merge]
    tool = vimdiff
[alias]
    lg = log --graph --oneline
```

##  ~/.jupyter/jupyter_notebook_config.py

change following settings to open with firefox, regardless of default browser
```
c.LabServerApp.open_browser = True
c.JupyterNotebookApp.open_browser = True
c.ExtensionApp.open_browser = True
c.ServerApp.browser = 'open -a Firefox %s'
```
