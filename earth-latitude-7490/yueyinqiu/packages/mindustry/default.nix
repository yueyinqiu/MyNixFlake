{ pkgs, nixpkgs-master, ... }: {
    my.r.mindustry = ''
        "${pkgs.mindustry-wayland}/bin/mindustry"
    '';
}