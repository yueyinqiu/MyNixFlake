{ config, ... }: {
    imports = [
        ./nix-daemon-proxy
    ];

    my.r.cd-sing-box-config = ''
        cd "${config.xdg.configHome}/sing-box"
    '';
}
