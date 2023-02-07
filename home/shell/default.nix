{ lib, ... }:

{
  imports = [ 
    ./nvim.nix 
    ./starship.nix 
    ./vim.nix 
    ./zsh.nix 
    ./alcritty.nix
  ];
}