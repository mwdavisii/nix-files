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
      character = {
        success_symbol = "[>](bold green)";
      };
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
      git_status = {
          conflicted = "🏳";
          ahead = "🏎💨";
          behind = "😰";
          diverged = "😵";
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

      status = {
        style = "bg:blue";
        symbol = "🔴 ";
        success_symbol = "🟢 SUCCESS";
        format = "[\[$symbol$common_meaning$signal_name$maybe_int\]]($style) ";
        map_symbol = true;
        disabled = false;
      };
      time = {
        disabled = false;
        time_format = "%T";
        utc_time_offset = "-6";
        time_range = "10:00:00-14:00:00";
      };
    };
  };
}