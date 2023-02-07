{ config, pkgs, ... }:

{
    home.packages = with pkgs;
      [
        # This is required to be from unstable as discord will sometimes soft-lock
        # on "there is an update" screen.
        discord
      ];
}