{ pkgs, ... }: {
  home.packages = with pkgs; [
    _7zz
    (writeShellApplication "7zz-x" ''
      target="$1"
      name="$(basename "$target")"
      name="''${name%.*}"
      mkdir -p "$name"
      7zz x "$target" -o"$name"
    '')
  ];
}
