{ config, pkgs, ... }:


{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
    # Configuration written to ~/.config/starship.toml
    settings = {
      scan_timeout = 10;
      add_newline = false;
      package = {
        disabled = true;
      };
      aws = {
        format = "on [$symbol($profile )(\($region\) )]($style)";
        style = "bold blue";
        symbol = "๐ฐ ";
        region_aliases = {
          ap-northeast-1 = "jp";
          us-west-2 = "Oregon";
        };
      };
      conda = {
        format = "[$symbol$environment](dimmed green) ";
      };
      nodejs = {
        format = "via [๐ค $version](bold green) ";
      };
      #git_branch = {
      #    symbol = "๐ฑ ";
      #    truncation_length = 4;
      #    truncation_symbol = "";
      #};
      git_commit = {
        commit_hash_length = 4;
        tag_symbol = "๐ ";
      };
      git_status = {
          conflicted = "๐ณ";
          ahead = "โก$count";
          diverged = "โโก$ahead_countโฃ$behind_count";
          behind = "โฃ$count";
          untracked = "๐คท";
          stashed = "๐ฆ";
          modified = "๐";
          staged = "[++\($count\)](green)";
          renamed = "๐";
          deleted = "๐";
      };
      golang = {
        format = "via [๐๐จ $version](bold cyan) ";
      };
      kubernetes = {
        format = "on [โต ($user on )($cluster in )$context \($namespace\)](dimmed green) ";
        disabled = false;
        detect_files = ["gitops" "eks"];
        context_aliases = {
          "dev.local.cluster.k8s" = "dev";
        };
      };

      opa = {
        format = "via [โ๏ธ  $version](bold red) ";
      };
      python = {
        symbol = "๐พ ";
        pyenv_version_name = true;
      };
      time = {
        disabled = false;
        time_format = "%R"; # Hour:Minute Format
        format = "๐ $time ";
      };
    };
  };
}