{ lib, config, ... }: {
  options.my.navi-cheats = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [ ];
  };

  config = {
    programs.navi.enable = true;
    programs.navi.enableBashIntegration = true;

    home.file = builtins.listToAttrs (
      lib.imap1 (i: content: {
        name = ".local/share/navi/cheats/cheat-${toString i}.cheat";
        value = {
          text = content;
        };
      }) config.my.navi-cheats
    );

    my.navi-cheats = [
      ''
        % navi

        # run navi, an interactive cheatsheet tool for the command-line.
        navi
      ''
    ];
  };
}
