# Parking lot for things to include\:

nix -i chrome-browser
nix -iA neofetch
zip
unzip

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

bind-utils
time-zone
tracert

nix-env -iA nixos.awscli2

nix-env -iA nixos.kubectl