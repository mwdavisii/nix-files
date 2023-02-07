{ config, pkgs, ... }:

{
    home.packages = with pkgs;
      [
        python39
        pipenv
        
      ];
    home.packages = with pkgs.python39Packages; [
        black
        jedi
        pip
        poetry
        pylint
        setuptools
        venv
      ];  
}