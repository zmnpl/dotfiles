# source others
# aliases
[ -f $HOME/Nas/Linux/ssh_alias.zsh ] && source $HOME/Nas/Linux/ssh_alias.zsh
[ -f $HOME/dotfiles/aliasrc ] && source $HOME/dotfiles/aliasrc
#[ -f $HOME/dotfiles/environmentrc ] && source $HOME/dotfiles/environmentrc
#[ -f $HOME/dotfiles/functionsrc ] && source $HOME/dotfiles/functionsrc

# fd
set FD_OPTIONS "--follow --exclude .git --exclude node_modules"

# fzf
set FZF_DEFAULT_COMMAND 'fd --type f'
set FZF_DEFAULT_OPTS '--reverse --preview="bat --color always --theme Nord {}" --height=40% --preview-window=right:70%:wrap'
set FZF_CTRL_T_COMMAND "fd $FD_OPTIONS"
set FZF_ALT_C_COMMAND "fd --type d $FD_OPTIONS"

# golang
set GOPATH $HOME/go
set GOBIN $GOPATH/bin
set PATH $PATH:$GOPATH/bin

# cdpath
set CDPATH ".:~:/home/simon/go/src/github.com/zmnpl/:/home/simon/Nas/:/home/simon/workspace"

# android sdk
set PATH $PATH:$HOME/workspace/android-sdk-linux/platform-tools

# own scripts path
set PATH $PATH:~/scripts
set PATH $PATH:~/scripts/backup
set PATH $PATH:~/scripts/photoworkflow
set PATH $PATH:~/scripts/doomlauncher

# pico-8
set PATH $PATH:~/Nas/Linux/pico-8

set EDITOR nvim

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /home/simon/miniconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

