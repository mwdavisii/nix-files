{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.programs.exa;

  aliases = {
    ls = "${pkgs.exa}/bin/exa";
    ll = "${pkgs.exa}/bin/exa -l";
    la = "${pkgs.exa}/bin/exa -a";
    lt = "${pkgs.exa}/bin/exa --tree";
    lla = "${pkgs.exa}/bin/exa -la";
  };

in {
  meta.maintainers = [ hm.maintainers.kalhauge ];

  options.programs.exa = {
    enable =
      mkEnableOption "exa, a modern replacement for <command>ls</command>";

    enableAliases = mkEnableOption "recommended exa aliases";

    package = mkPackageOption pkgs "exa" { };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    programs.bash.shellAliases = mkIf cfg.enableAliases aliases;
    programs.zsh.shellAliases = mkIf cfg.enableAliases aliases;
    programs.fish.shellAliases = mkIf cfg.enableAliases aliases;
    programs.ion.shellAliases = mkIf cfg.enableAliases aliases;
  };
}