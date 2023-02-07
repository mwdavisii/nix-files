{ lib, ... }:

{
  imports = [ 
    ./exa.nix
    ./nvim.nix 
    ./starship.nix 
    ./vim.nix 
    ./zsh.nix 
  ];
}