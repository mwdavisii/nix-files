{ config, pkgs, ... }:

{
    programs.alacritty = {
        enable = true;
        settings = ''
          colors:
            primary:
              background: "0x${bg}"
              foreground: "0x${fg}"
            normal:
              black:   '0x${base.black}'
              red:     '0x${base.red}'
              green:   '0x${base.green}'
              yellow:  '0x${base.yellow}'
              blue:    '0x${base.blue}'
              magenta: '0x${base.magenta}'
              cyan:    '0x${base.cyan}'
              white:   '0x${base.white}'
            bright:
              black:   '0x${bright.black}'
              red:     '0x${bright.red}'
              green:   '0x${bright.green}'
              yellow:  '0x${bright.yellow}'
              blue:    '0x${bright.blue}'
              magenta: '0x${bright.magenta}'
              cyan:    '0x${bright.cyan}'
              white:   '0x${bright.white}'
        '';
    };
}