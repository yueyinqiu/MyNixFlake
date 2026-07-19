{ lib, ... }: {
  programs.yazi.enable = true;
  programs.yazi.settings = {
    yazi = lib.importTOML ./yazi.toml;
    keymap = lib.importTOML ./keymap.toml;
  };
  my.r.yazi = ''
    yazi "$@"
  '';
}
