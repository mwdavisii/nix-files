# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export NIX_PATH=${NIX_PATH:+$NIX_PATH:}$HOME/.nix-defexpr/channels

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh
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

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  jsontools
  macports
  sudo
  thor
  docker
)

source $ZSH/oh-my-zsh.sh

# User configuration


# export MANPATH="/usr/local/man:$MANPATH"

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
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
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm3_shell_integration.zsh"

### VISUAL CUSTOMISATION ###

# Elements options of left prompt (remove the @username context)
POWERLEVEL10K_LEFT_PROMPT_ELEMENTS=(dir rbenv vcs)
# Elements options of right prompt
POWERLEVEL10K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs history time)

# Add a second prompt line for the command
POWERLEVEL10K_PROMPT_ON_NEWLINE=true

# Add a space in the first prompt
POWERLEVEL10K_MULTILINE_FIRST_PROMPT_PREFIX="%f"

# Visual customisation of the second prompt line
local user_symbol="$"
if [[ $(print -P "%#") =~ "#" ]]; then
    user_symbol = "#"
fi
POWERLEVEL10K_MULTILINE_LAST_PROMPT_PREFIX="%{%B%F{black}%K{yellow}%} $user_symbol%{%b%f%k%F{yellow}%} %{%f%}"

# Change the git status to red when something isn't committed and pushed
POWERLEVEL10K_VCS_MODIFIED_BACKGROUND='red'

# Add a new line after the global prompt
POWERLEVEL10K_PROMPT_ADD_NEWLINE=true

source $ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# This is an attempt to make sure venv is runing when in Python Directories
# it looks for requirements.txt or a requirements.txt file.
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
export PATH=$PATH:$HOME/bin
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
source <(kubectl completion zsh)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
