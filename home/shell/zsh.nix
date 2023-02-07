{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    shellGlobalAliases = {
      "ls"="exa -alG";
      "clr"="clear";
      "vi"="nvim";
      "pip"="pip3";
      "python"="python3";
      "ip"="curl -4 icanhazip.com"; #public IP address
      "ll"="ls -alG";
      "ldir"="ls -al | grep ^d";
      "o"="open .";
      "ut"="uptime";
      "lip"="ifconfig | grep \"inet \" | grep -Fv 127.0.0.1 | awk '{print $2}'";
      "k"="kubectl";
      "kap"="kubectl apply -f ";
      "kad"="kubectl delete -f ";
    };
  };
}