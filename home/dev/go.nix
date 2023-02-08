{ lib, pkgs, ... }:

{
    programs.go = {
        enable = true;
        packages = {
            "golang.org/x/text" = builtins.fetchGit "https://go.googlesource.com/text";
            "golang.org/x/time" = builtins.fetchGit "https://go.googlesource.com/time";
        };
        goPath = "/home/mwdavis/go";
        goBin = "~/.nix-profile/bin/";
        goPrivate = [
            "github.com/uLabSystems"
        ];
    };
}