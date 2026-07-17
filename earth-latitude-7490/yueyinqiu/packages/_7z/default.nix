{ pkgs, ... }: {
  home.packages = with pkgs; [
    _7zz
  ];

  my.r."7z" = ''
    7zz "$@"
  '';
  my.r."7z-a" = ''
    7zz a "$@"
  '';
  my.r."7z-x" = ''
    target="$1"
    name="$(basename "$target")"
    name="''${name%.*}"
    mkdir -p "$name"
    7zz x "$target" -o"$name"
  '';
}
