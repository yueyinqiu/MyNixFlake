{ pkgs, nixpkgs-master, ... }: {
    my.r.mindustry = ''
        "${nixpkgs-master.mindustry-wayland}/bin/mindustry"
    '';
}