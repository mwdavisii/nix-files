{ config, pkgs, ... }:


{
  programs.home-manager.enable = true;
  home.username = "mwdavisii";
  home.homeDirectory = "/home/mwdavisii";
  home.stateVersion = "23.05";

  home = {
    packages = with pkgs; [
      python39
      pipenv
      tmux
    ];
  };
  #home.file.".zshrc".source = ../dotfiles/.zshrc;
  home.file.".bashrc".source = ../dotfiles/.bashrc;
  home.file.".gitconfig".source = ../dotfiles/.gitconfig;
  home.file.".nix-channels".source = ../dotfiles/.nix-channels;
  home.file.".profile".source = ../dotfiles/.profile;
  home.file.".config/nvim/init.vim".source = ../dotfiles/.config/nvim/init.vim;
  home.file.".config/starship/starship.toml".source = ../dotfiles/.config/starship/starship.toml;
  
  imports = [
    ./apps/default.nix
    ./shell/default.nix
    ./common/default.nix
    ./dev/default.nix
  ];
}
