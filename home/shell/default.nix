{ lib, ... }:

{
  imports = [ 
    ./exa.nix
    ./k9s.nix
    ./nvim.nix 
    ./starship.nix 
    ./vim.nix 
    ./zsh.nix 
  ];
}