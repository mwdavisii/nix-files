{ config, lib, pkgs, ... }:

{
    home.packages = with pkgs; [ nodejs yarn ];

    home.sessionVariables = {
      #NPM_CONFIG_USERCONFIG = "${configHome}/npm/config";
      #NPM_CONFIG_CACHE = "${configHome}/npm";
      #PM_CONFIG_TMP = "${cacheHome}/tmp/npm";
      #NPM_CONFIG_PREFIX = "${dataHome}/npm";
      #NODE_REPL_HISTORY = "${cacheHome}/node/repl_history";
    };
}