{ lib, ... }:

{
  imports = [ 
    ./go.nix
    ./python.nix
    ./lua.nix
    ./nix.nix
    ./node.nix
  ];
}