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
  my.r.yazi-tty-bash = ''
    ghostty --working-directory="$1" --command="expect \"${./yazi-tty-bash.exp}\""
  '';
}
