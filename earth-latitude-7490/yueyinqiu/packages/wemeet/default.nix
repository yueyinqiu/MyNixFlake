{ pkgs, ... }: {
    my.r.wemeet = ''
        "${pkgs.wemeet}/bin/wemeet"
    '';
}