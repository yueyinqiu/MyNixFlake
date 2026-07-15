{ ... }: {
    my.r.sing-box = ''
        "${pkgs.sing-box}/bin/sing-box" "$@"
    '';
}
