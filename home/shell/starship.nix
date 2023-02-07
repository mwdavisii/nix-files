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
        symbol = "🅰 ";
        region_aliases = {
          ap-northeast-1 = "jp";
          us-west-2 = "Oregon";
        };
      };
      conda = {
        format = "[$symbol$environment](dimmed green) ";
      };
      nodejs = {
        format = "via [🤖 $version](bold green) ";
      };
      #git_branch = {
      #    symbol = "🌱 ";
      #    truncation_length = 4;
      #    truncation_symbol = "";
      #};
      git_commit = {
        commit_hash_length = 4;
        tag_symbol = "🔖 ";
      };
      git_status = {
          conflicted = "🏳";
          ahead = "⇡$count";
          diverged = "⇕⇡$ahead_count⇣$behind_count";
          behind = "⇣$count";
          untracked = "🤷";
          stashed = "📦";
          modified = "📝";
          staged = "[++\($count\)](green)";
          renamed = "👅";
          deleted = "🗑";
      };
      golang = {
        format = "via [🏎💨 $version](bold cyan) ";
      };
      kubernetes = {
        format = "on [⛵ ($user on )($cluster in )$context \($namespace\)](dimmed green) ";
        disabled = false;
        detect_files = ["gitops" "eks"];
        context_aliases = {
          "dev.local.cluster.k8s" = "dev";
        };
      };

      opa = {
        format = "via [⛑️  $version](bold red) ";
      };
      python = {
        symbol = "👾 ";
        pyenv_version_name = true;
      };
      time = {
        disabled = false;
        time_format = "%R"; # Hour:Minute Format
        format = "🕙 $time ";
      };
    };
  };
}