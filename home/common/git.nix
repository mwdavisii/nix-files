{ config, pkgs, ... }:


{
    programs.git = {
        enable = true;
        userName = "Mike D.";
        userEmail = "mwdavisii@gmail.com";
        extraConfig = {
            url."ssh://git@github.com/".insteadOf = "https://github.com/";
            init.defaultBranch = "main";
        };
    };
}
