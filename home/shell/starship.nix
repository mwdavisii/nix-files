{ config, pkgs, ... }:


{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
    # Configuration written to ~/.config/starship.toml
    settings =  ''
        # Get editor completions based on the config schema
        "$schema" = 'https://starship.rs/config-schema.json'

        format = '''
        [┌───────────────────>](bold green)
        [│](bold green)$directory$rust$package
        [└─>](bold green) '''

        # Wait 10 milliseconds for starship to check files under the current directory.
        scan_timeout = 10

        # Disable the blank line at the start of the prompt
        add_newline = false

        # Set 'foo' as custom color palette
        palette = 'foo'

        # Define custom colors
        [palettes.foo]
        # Overwrite existing color
        blue = '21'
        # Define new color
        mustard = '#af8700'

        # Inserts a blank line between shell prompts
        add_newline = true

        # Replace the '❯' symbol in the prompt with '➜'
        [character] # The name of the module we are configuring is 'character'
        success_symbol = '[➜](bold green)' # The 'success_symbol' segment is being set to '➜' with the color 'bold green'

        # Disable the package module, hiding it from the prompt completely
        [package]
        disabled = true

        [aws]
        format = 'on [$symbol($profile )(\($region\) )]($style)'
        style = 'bold blue'
        symbol = '🅰 '
        [aws.region_aliases]
        ap-northeast-1 = 'au'
        us-west-2 = 'Oregon'

        [conda]
        format = '[$symbol$environment](dimmed green) '

        [git_status]
        conflicted = '🏳'
        ahead = '🏎💨'
        behind = '😰'
        diverged = '😵'
        up_to_date = '✓'
        untracked = '🤷'
        stashed = '📦'
        modified = '📝'
        staged = '[++\($count\)](green)'
        renamed = '👅'
        deleted = '🗑'

        [golang]
        format = 'via [🏎💨 $version](bold cyan) '

        # ~/.config/starship.toml

        [kubernetes]
        format = 'on [⛵ ($user on )($cluster in )$context \($namespace\)](dimmed green) '
        disabled = false
        detect_files = ['gitops']
        [kubernetes.context_aliases]
        'dev.local.cluster.k8s' = 'dev'

        [opa]
        format = 'via [⛑️  $version](bold red) '

        [shell]
        fish_indicator = ''
        powershell_indicator = '_'
        unknown_indicator = 'mystery shell'
        style = 'cyan bold'
        disabled = false

        [status]
        style = 'bg:blue'
        symbol = '🔴 '
        success_symbol = '🟢 SUCCESS'
        format = '[\[$symbol$common_meaning$signal_name$maybe_int\]]($style) '
        map_symbol = true
        disabled = false

        [time]
        disabled = false
        format = '🕙[\[ $time \]]($style) '
        time_format = '%T'
        utc_time_offset = '-5'
        time_range = '10:00:00-14:00:00'

    '';
  };
}