#########################################################################################
#  Code Helpers
#########################################################################################
# Load python venv
# This is an attempt to make sure venv is runing when in Python Directories
# it looks for a .venv folder and or requirements.txt file


## Evals & Sources
#source $ZSH/oh-my-zsh.sh
#source $ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


if [ -e /home/mwdavisii/.nix-profile/etc/profile.d/nix.sh ]; then . /home/mwdavisii/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer