{ pkgs, ... }: {
    my.r.opencode = ''
        "${pkgs.opencode}/bin/opencode" "$@"
    '';
}