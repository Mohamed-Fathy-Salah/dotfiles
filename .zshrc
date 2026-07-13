# exec dbus-launch --exit-with-session dwm
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

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
SAVEHIST=10000
HISTSIZE=10000
HISTFILESIZE=10000
HISTFILE=~/.cache/zsh/history

source ~/.config/zsh/aliases
source ~/.config/zsh/keys

function hlp(){curl cheat.sh/$1}

function dins() { fzf --print-query --bind "change:reload(dotnet package search --take 5 --format json --verbosity minimal {q} | jq -r '.searchResult[].packages[].id')" --bind "enter:become(dotnet add package {})" --header "Type to search packages, Enter to install"; }
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

compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/mofasa/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/home/mofasa/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
#if [ -f '/home/mofasa/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/mofasa/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
. "/home/mofasa/.local/share/deno/env"
export PATH=$PATH:$HOME/.maestro/bin

eval "$(rbenv init - --no-rehash zsh)"

# >>> railway initialize >>>
source "$HOME/.railway/env"
# <<< railway initialize <<<


# Added by Antigravity CLI installer
export PATH="/home/mofasa/.local/bin:$PATH"

# Persistent shared ssh-agent (one passphrase entry per boot)
#export SSH_AUTH_SOCK="$HOME/.ssh/agent.sock"
#ssh-add -l &>/dev/null
#if [ $? -eq 2 ]; then
  #rm -f "$SSH_AUTH_SOCK"
  #eval "$(ssh-agent -a "$SSH_AUTH_SOCK")" &>/dev/null
#fi
