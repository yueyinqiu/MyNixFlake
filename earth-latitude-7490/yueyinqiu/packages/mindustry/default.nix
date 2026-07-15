{ pkgs, ... }: {
    my.r.mindustry = ''
        "${pkgs.mindustry-wayland}/bin/mindustry"
    '';
}