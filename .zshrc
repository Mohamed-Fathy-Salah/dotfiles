# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/.config/zsh/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
source ~/.config/zsh/powerlevel10k/powerlevel10k.zsh-theme

# GITSTATUS_LOG_LEVEL=DEBUG

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
SAVEHIST=10000
HISTSIZE=10000
HISTFILESIZE=10000
HISTFILE=~/.cache/zsh/history

# some more ls aliases
alias ll='ls --color=auto -alF'
alias la='ls --color=auto -A'
alias l='ls --color=auto -CF'
# alias less='less -R'
####
alias q='exit'
alias sz='du -ah --max-depth=1'
####
alias arem='sudo pacman -Rns $(pacman -Qdtq)'
alias ins='sudo pacman -Sy'
alias upg='sudo pacman -Syu'
alias rem='sudo pacman -Rns'
####
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
####
alias d="sudo systemctl start docker && minikube start && minikube addons enable ingress"
alias k="minikube kubectl --"
alias curl="curl -s"
####
alias dn="herbe done"
####

function hlp(){curl cheat.sh/$1}
# vim keybindings 
bindkey -v
bindkey jk vi-cmd-mode
bindkey JK vi-cmd-mode
export KEYTIMEOUT=10

# autocomplete
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#__conda_setup="$('/home/mofasa/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
#if [ $? -eq 0 ]; then
    #eval "$__conda_setup"
#else
    #if [ -f "/home/mofasa/miniconda3/etc/profile.d/conda.sh" ]; then
        #. "/home/mofasa/miniconda3/etc/profile.d/conda.sh"
    #else
        #export PATH="/home/mofasa/miniconda3/bin:$PATH"
    #fi
#fi
#unset __conda_setup
## <<< conda initialize <<<

