{ pkgs, ... }: {
    my.r.mindustry-server = ''
        "${pkgs.mindustry-server}/bin/mindustry-server"
    '';
}