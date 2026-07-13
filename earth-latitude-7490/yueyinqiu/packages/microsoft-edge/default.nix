{ pkgs, ... }: {
    my.r.e = ''
        "${pkgs.microsoft-edge}/bin/microsoft-edge" --proxy-server=localhost:7890
    '';
    my.r.edge = ''
        "${pkgs.microsoft-edge}/bin/microsoft-edge" --proxy-server=localhost:7890
    '';
}