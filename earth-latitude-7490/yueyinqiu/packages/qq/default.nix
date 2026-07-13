{ pkgs, ... }: {
    my.r.qq = ''
        "${pkgs.qq}/bin/qq"
    '';
}