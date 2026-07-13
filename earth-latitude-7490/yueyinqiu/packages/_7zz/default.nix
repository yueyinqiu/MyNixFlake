{ pkgs, ... }: {
    home.packages = with pkgs; [
        _7zz
    ];

    my.r."7z-zip" = "${pkgs._7zz}/bin/7zz a $@";
    my.r."7z-unzip" = ''
        target="$1"
        name="$(basename "$target")"
        name="''${name%.*}"
        mkdir -p "$name"
        ${pkgs._7zz}/bin/7zz x "$target" -o"$name"
    '';
}
