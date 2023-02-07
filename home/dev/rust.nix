{ config, pkgs, ... }:

{
    home = {
      packages = with pkgs; [
        (fenix.stable.withComponents cfg.stableComponents)
        (fenix.latest.withComponents cfg.nightlyComponents)
      ] ++ cfg.extraPackages ++ (optional cfg.rust-analyzer fenix.rust-analyzer);

      sessionVariables = {
        #RUSTUP_HOME = "${config.xdg.dataHome}/rustup";
        #CARGO_HOME = "${config.xdg.dataHome}/cargo";
      };

      sessionPath = [ "$CARGO_HOME/bin" ];
    };
}