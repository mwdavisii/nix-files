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
  home.file.".zshrc".source = ./dotfiles/.zshrc;
  home.file.".bashrc".source = ./dotfiles/.bashrc;
  home.file.".gitconfig".source = ./dotfiles/.gitconfig;
  home.file.".nix-channels".source = ./dotfiles/.nix-channels;
  home.file.".profile".source = ./dotfiles/.profile;
  home.file.".config/nvim/init.vim".source = ./dotfiles/.config/nvim/init.vim;
  home.file.".config/starship/starship.toml".source = ./dotfiles/.config/starship/starship.toml;
  
  imports = [
    ./programs/git.nix
  ];

  programs.zsh = {
    enable = true;
  };

  programs.starship = {
    enable = true;
    # Configuration written to ~/.config/starship.toml
    settings = {
      # add_newline = false;

      # character = {
      #   success_symbol = "[➜](bold green)";
      #   error_symbol = "[➜](bold red)";
      # };

      # package.disabled = true;
    };
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };

  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ vim-airline ];
    settings = { ignorecase = true; };
    extraConfig = ''
      set mouse=a
    '';
  };
}
