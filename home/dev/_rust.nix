{ config, pkgs, ... }:

{
    home = {
      packages = with pkgs; [
        (fenix.stable.withComponents cfg.stableComponents)
        (fenix.latest.withComponents cfg.nightlyComponents)
      ];

      sessionVariables = {
        #RUSTUP_HOME = "${config.xdg.dataHome}/rustup";
        #CARGO_HOME = "${config.xdg.dataHome}/cargo";
      };

      sessionPath = [ "$CARGO_HOME/bin" ];
    };
}