{ config, pkgs, ... }:

{
    home.packages = with pkgs;
      [
        python39
        pipenv
      ];
}