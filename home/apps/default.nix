{ lib, ... }:

{
  imports = [ 
    ./alcritty.nix
    ./discord.nix
    ./vscode.nix
    ./wezterm.nix
    ];
}