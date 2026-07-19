{ lib, ... }: {
  programs.yazi.enable = true;
  programs.yazi.settings = lib.importTOML ./yazi.toml;
  programs.yazi.keymap = lib.importTOML ./keymap.toml;
  my.r.yazi = ''
    yazi "$@"
  '';
  my.r.yazi-tty = ''
    ghostty --command=yazi --working-directory="$1"
  '';
}
