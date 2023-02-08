{ config, pkgs, ... }:


{
    programs.git = {
        enable = true;
        userName = "Mike D.";
        userEmail = "mwdavisii@gmail.com";
        extraConfig = {
            url."ssh://git@github.com/uLabSystems/".insteadOf = "https://github.com/uLabSystems/";
            init.defaultBranch = "main";
        };
    };
}
