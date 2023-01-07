{ config, pkgs, ... }:



#let 
#  mkPersistentLink = path: pkgs.runCommand "persistent-link" {} ''
#    builtins.trace ''ln -s $HOME/${path}''
#    ln -s $HOME/${path} $out
#  '';

#in 
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "mwdavisii";
  home.homeDirectory = "/home/mwdavisii";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ vim-airline ];
    settings = { ignorecase = true; };
    extraConfig = ''
      set mouse=a
    '';
  };

  #packages to install
  home.packages = [
    # pkgs is the set of all packages in the default home.nix implementation
    pkgs.tmux
  ];
  home.file.".zshrc".source = ./.zshrc;
  home.file.".gitconfig".source = ./.gitconfig;
  home.file.".nix-channels".source = ./.nix-channels;
  home.file.".p10k.zsh".source  = ./.p10k.zsh;
  home.file.".zprofile".source = ./.zprofile;
  home.file.".profile".source = ./.profile;
  home.file.".config/nvim/init.vim".source = ./.config/nvim/init.vim;

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };
}
