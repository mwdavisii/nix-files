{ lib, pkgs, ... }:

{
    home = {
        packages = with pkgs; [
            go
            # linters and static analysis
            go-tools
            gopls
            go-outline
            gocode
            gopkgs
            gocode-gomod
            godef
            golint

        ];
        sessionVariables = {
            GOPATH = "/home/mwdavisii/go";
            GOBIN = "/home/mwdavisii/.nix-profile/bin/";
            GOPRIVATE = "github.com/uLabSystems";        
        };
    };  
}
