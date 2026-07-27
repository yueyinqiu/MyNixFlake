{ lib, config, ... }: {
  options.my.navi-cheats = lib.mkOption {
    type = lib.types.attrsOf lib.types.str;
    default = { };
  };

  config = {
    programs.navi.enable = true;
    programs.navi.enableBashIntegration = true;

    home.file = lib.mapAttrs' (name: value: {
      name = ".local/share/navi/cheats/${name}.cheat.md";
      value = {
        text = value;
      };
    }) config.my.navi-cheats;
  };
}
