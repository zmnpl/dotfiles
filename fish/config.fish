

# fd
set FD_OPTIONS "--follow --exclude .git --exclude node_modules"
# fzf
set FZF_DEFAULT_COMMAND 'fd --type f'
set FZF_DEFAULT_OPTS '--reverse --preview="bat --color always --theme Nord {}" --height=40% --preview-window=right:70%:wrap'
set FZF_CTRL_T_COMMAND "fd $FD_OPTIONS"
set FZF_ALT_C_COMMAND "fd --type d $FD_OPTIONS"

# source fzf key bindings
#if [[ -s "/usr/share/fzf/key-bindings.zsh" ]]; then
#  source "/usr/share/fzf/key-bindings.zsh"
#  source "/usr/share/fzf/completion.zsh"
#  source "/usr/share/fzf/key-bindings.zsh"
#fi

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

# aliases
alias vim=nvim
set EDITOR nvim
alias fzfvim='vim `fzf`'

alias doomseeker='vblank_mode=0 GALLIUM_HUD=fps doomseeker'
alias vim='nvim'

alias mutt='neomutt'
alias cp='cp -v'
alias rm='rm -v'
alias feh='feh -T simondefault'
alias fuckoff='sudo shutdown -h now'
alias n8='systemctl suspend'
#alias winvm='/usr/lib/virtualbox/VirtualBox --comment "win7" --startvm "866c04cd-1173-4a34-9d7e-1ea5bb2f03c2"'
alias gotop='gotop --color=monokai --percpu'

# pacman aliases
alias whatsinaur='pacman -Qqm'
alias whatsinstalled='pacman -Qet | grep -v "^xorg" | grep -v "^xfce"'

# git aliases
alias "git-lg"="git log --oneline"
alias "git-graph"="git log --graph"
alias "gadd"="git add --all"
alias "gommit"="git commit --m"

# crypto
# keychain
alias keychain-unlock='eval `keychain --eval --agents ssh id_rsa_space`'
# close crypt drives
alias cryptCloseUsbBackup='sudo cryptsetup close /dev/mapper/backupusb'

#screenfetch
neofetch

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /home/simon/miniconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

