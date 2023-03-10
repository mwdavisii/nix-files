{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;
  home.username = "mwdavisii";
  home.homeDirectory = "/home/mwdavisii";
  home.stateVersion = "23.05";

  home = {
    packages = with pkgs; [
      
    ];
  };
  home.file.".nix-channels".source = ../dotfiles/.nix-channels;
  #home.file.".config/nvim/init.vim".source = ../dotfiles/.config/nvim/init.vim;
  home.file.".bashrc".source = ../dotfiles/.bashrc;
  home.file.".aws/config".source = ../dotfiles/.aws/config;

  imports = [
    ./apps
    ./shell
    ./common
    ./cloud
    ./dev
  ];
}
