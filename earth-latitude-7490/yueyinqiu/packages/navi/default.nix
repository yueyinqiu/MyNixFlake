{ lib, config, ... }: {
  options.my.navi-cheats = lib.mkOption {
    type = lib.types.attrsOf lib.types.str;
    default = { };
  };

  config = {
    programs.navi.enable = true;
    programs.navi.enableBashIntegration = true;
    programs.navi.settings = {
      finder = {
        overrides_var = "--no-select-1 --bind alt-enter:replace-query";
      };
    };

    home.file = lib.mapAttrs' (name: content: {
      name = ".local/share/navi/cheats/${name}.cheat";
      value = {
        text = "% ${name}\n\n${lib.trim content}\n";
      };
    }) config.my.navi-cheats;

    my.navi-cheats.navi = ''
      # run navi, an interactive cheatsheet tool for the command-line.
      navi
    '';
  };
}
