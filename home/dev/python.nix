{ config, pkgs, ... }:

{
    home.packages = with pkgs;
      [
        python39
        pipenv
        python39Packages[
            black
            jedi
            pip
            poetry
            pylint
            setuptools
            venv
        ]
      ];
}