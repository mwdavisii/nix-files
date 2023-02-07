{ lib, pkgs, ... }:

{
    Shome.packages = with pkgs; [
      nix-prefetch-git
      nix-prefetch-github
    ];
}