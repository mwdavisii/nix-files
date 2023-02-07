{ config, pkgs, ... }:

{
    home.packages = with pkgs;
      [
        python39
        pipenv
        black
        jedi
        pip
        poetry
        pylint
        setuptools
      ];
}