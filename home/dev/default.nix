{ lib, ... }:

{
  imports = [ 
    ./go.nix
    ./python.nix
    ./pythonPkgs.nix
    ./lua.nix
    ./nix.nix
    ./node.nix
  ];
}