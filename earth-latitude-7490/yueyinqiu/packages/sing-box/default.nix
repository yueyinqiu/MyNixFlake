{ config, ... }: {
    imports = [
        ./nix-daemon-proxy
    ];

    my.r.sing-box-config = ''
        cd "${config.xdg.configHome}/sing-box"
        code .
    '';
}
