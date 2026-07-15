{ pkgs, ... }: {
  my.r."7z" = ''
    "${pkgs._7zz}/bin/7zz" "$@"
  '';
  my.r."7z-a" = ''
    "${pkgs._7zz}/bin/7zz" a "$@"
  '';
  my.r."7z-x" = ''
    target="$1"
    name="$(basename "$target")"
    name="''${name%.*}"
    mkdir -p "$name"
    "${pkgs._7zz}/bin/7zz" x "$target" -o"$name"
  '';
}
