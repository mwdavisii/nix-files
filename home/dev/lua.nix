{ lib, pkgs, ... }:

{
    home.packages = with pkgs; [ 
        lua52Packages.lua 
        sumneko-lua-language-server 
    ];
}