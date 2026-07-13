{ config, lib, pkgs, ... }: {
    # sing-box does not support fallback
    # https://github.com/SagerNet/sing-box/pull/4217
    systemd.services.nix-daemon-proxy = {
        description = "nix-daemon proxy";
        after = [ "network.target" ];
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
            ExecStart = "${pkgs.mihomo}/bin/mihomo -f ${./config.yaml}";
            Restart = "on-failure";
            RestartSec = "5s";
        };
    };

    systemd.services.nix-daemon = {
        environment = {
            http_proxy = "socks5h://127.0.0.1:52138";
            https_proxy = "socks5h://127.0.0.1:52138";
            all_proxy = "socks5h://127.0.0.1:52138";
        };
    };
}
