{ pkgs, ... }: {
  home.packages = with pkgs; [
    _7zz

    (writeShellApplication {
      name = "7zz-x";
      runtimeInputs = [
        pkgs._7zz
      ];
      text = ''
        target="$1"
        name="$(basename "$target")"
        name="''${name%.*}"
        mkdir -p "$name"
        7zz x "$target" -o"$name"
      '';
    })
  ];
}
