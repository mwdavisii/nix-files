{ lib, ... }:

{
  imports = [ 
    ./vscode.nix
    ./go.nix
    ./python.nix
    #./cpp.nix
    #./rust.nix
  ];
}