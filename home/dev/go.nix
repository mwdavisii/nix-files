{ lib, pkgs, ... }:

{
    home = {
        packages = with pkgs; [
            go
            # linters and static analysis
            go-tools
        ];
        sessionVariables = {
            GOPATH = "/home/mwdavisii/go";
            GOBIN = "/home/mwdavisii/.nix-profile/bin/";
            GOPRIVATE = "github.com/uLabSystems";        
        };
    };  
}
