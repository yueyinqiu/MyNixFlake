{ pkgs, ... }: {
    my.r.mindustry = ''
        "${pkgs.mindustry}/bin/mindustry"
    '';
}