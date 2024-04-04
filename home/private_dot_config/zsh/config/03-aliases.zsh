# navegação
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~"
alias l="ls -lFh"
alias ll="ls -lah"
alias la="ls -AF"
alias lld="ls -l"
alias c="clear"
alias e="$EDITOR"
alias se="sudo $EDITOR"
alias ce="chezmoi edit"

# atalhos
alias dotfiles="cd ~/.local/src/dotfiles"
alias src='cd ~/.local/src'

# comandos
alias apt="sudo apt"
alias apagar="sudo rm -rf"
alias cls="clear"
alias procurar="sudo apt update && sudo apt search"
alias instalar="sudo apt update && sudo apt upgrade -y && sudo apt install -y"
alias reinstalar="sudo apt reinstall -y"
alias desinstalar="sudo apt remove -y"
alias autoremover="sudo apt autoremove -y"
alias atualizar="sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y"
alias sair="exit"
alias alertar='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

#git
alias ga="git add"
alias gb="git branch"
alias gc="git clone"
alias gcm="git commit -m"
alias gco="git checkout"
alias gcob="git checkout -b"
alias gcs="git commit -S -m"
alias gd="git difftool"
alias gdc="git difftool --cached"
alias gf="git fetch"
alias gg="git graph"
alias ggg="git graphgpg"
alias gm="git merge"
alias gp="git pull"
alias gps="git push"
alias gpr="gh pr create"
alias gr="git rebase -i"
alias gs="git status -sb"
alias gt="git tag"
alias gu="git reset @ --" #think git unstage
alias gx="git reset --hard @"
