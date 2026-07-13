{ config, ... }: {
    imports = [
        ./nix-daemon-proxy
    ];

    my.r.sing-box-config = "code ${config.xdg.configHome}/sing-box";
}
