{ lib, ... }:

{
  imports = [ 
    ./exa.nix
    ./fzf.nix
    ./jq.nix
    ./k9s.nix
    ./nvim.nix 
    ./starship.nix 
    ./vim.nix 
    ./zsh.nix 
  ];
}