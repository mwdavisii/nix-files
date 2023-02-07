{ lib, ... }:

{
  imports = [ 
    ./alacritty.nix
    ./discord.nix
    ./vscode.nix
    ./wezterm.nix
    ];
}