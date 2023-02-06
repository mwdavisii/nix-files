#########################################################################################
#  EXPORTS
#########################################################################################

#misc
export PATH=$PATH:$HOME/bin

#nix
export NIX_PATH=${NIX_PATH:+$NIX_PATH:}$HOME/.nix-defexpr/channels

#go
export GOROOT=/usr/local/go
export GOBIN=/usr/local/go/bin
export GOPRIVATE=github.com/uLabSystems
export GOPATH=$HOME/go
export PATH=$PATH:$GOBIN:$GOPATH
#python
export PATH=$PATH:~/.local/bin

#dotnet core
export PATH=$PATH:~/.dotnet

#node & nvm
export NODE_OPTIONS=--openssl-legacy-provider
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

#zsh
export ZSH=~/.oh-my-zsh

#########################################################################################
#  ALIASES
#########################################################################################

alias ls="exa -alG"
alias clr="clear"
alias vi="nvim"
alias pip="pip3"
alias python="python3"
alias ip="curl -4 icanhazip.com" #public IP address
alias ll="ls -alG"
alias ldir="ls -al | grep ^d"
alias o="open ."
alias ut="uptime"
alias lip="ifconfig | grep \"inet \" | grep -Fv 127.0.0.1 | awk '{print $2}'"
alias k="kubectl"
alias kap="kubectl apply -f "
alias kad="kubectl delete -f "


#########################################################################################
#  ZSH Configurations
#########################################################################################
CASE_SENSITIVE="true"
COMPLETION_WAITING_DOTS="true"

# Add wisely, as too many plugins slow down shell startup.
plugins=(
  zsh-autosuggestions
  zsh-syntax-highlighting
  docker
  fluxcd
)

# Visual customisation of the second prompt line
local user_symbol="$"
if [[ $(print -P "%#") =~ "#" ]]; then
    user_symbol = "#"
fi

#########################################################################################
#  Code Helpers
#########################################################################################
# Load python venv
# This is an attempt to make sure venv is runing when in Python Directories
# it looks for a .venv folder and or requirements.txt file
function cd() {
  builtin cd "$@"

  if [[ -z "$VIRTUAL_ENV" ]] ; then
    ## If env folder is found then activate the vitualenv
      if [[ -d ./.venv ]] ; then
        echo "Detected .venv folder."
	echo "Activating .venv"
	source ./.venv/bin/activate
	## If there is a requirements.txt file, go ahead and create a venv.
      elif [[ -f ./requirements.text ]]; then
	echo "Detected requirements.txt but no venv."
	echo "Creating venv at .venv"
	python3 -m venv .venv
	echo "Activating venv"
	source ./.venv/bin/activate
      fi
  else
    ## check the current folder belong to earlier VIRTUAL_ENV folder
    # if yes then do nothing
    # else deactivate
      parentdir="$(dirname "$VIRTUAL_ENV")"
      if [[ "$PWD"/ != "$parentdir"/* ]] ; then
	echo "Leaving project directory and deactivating .venv"
        deactivate
      fi
  fi
}

## Evals & Sources
source $ZSH/oh-my-zsh.sh
source $ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" #Homebrew
eval "$(startship init zsh)" #Launch Starship
source <(kubectl completion zsh) #Kubectl Autocompletion
. <(flux completion zsh) # Flux Autocompletion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh #fuzzyfind

if [ -e /home/mwdavisii/.nix-profile/etc/profile.d/nix.sh ]; then . /home/mwdavisii/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer