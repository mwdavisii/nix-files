{ config, pkgs, ... }:


{
  programs.home-manager.enable = true;
  home.username = "mwdavisii";
  home.homeDirectory = "/home/mwdavisii";
  home.stateVersion = "23.05";

  home.packages = [
    # pkgs is the set of all packages in the default home.nix implementation
    pkgs.tmux
  ];
  /*
  home.file.".zshrc".source = ../config/.zshrc;
  home.file.".bashrc".source = ../config/.bashrc;
  home.file.".gitconfig".source = ../config/.gitconfig;
  home.file.".nix-channels".source = ../config/.nix-channels;
  home.file.".profile".source = ../config/.profile;
  home.file.".config/nvim/init.vim".source = ../config/.config/nvim/init.vim;
  home.file.".config/starship/starship.toml".source = ../config/.config/starship/starship.toml;
  */
  
  imports = [
    ../programs/discord.nix
    ../programs/git.nix
    ../programs/nvim.nix
    ../programs/starship.nix
    ../programs/vim.nix
    #../programs/vscode.nix
    ../programs/zsh.nix
  ];
}
