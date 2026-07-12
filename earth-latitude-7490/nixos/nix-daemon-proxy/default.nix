{ config, lib, pkgs, ... }:
let
    ca = pkgs.runCommand "nix-daemon-proxy-create-certificates" { } ''
        ${pkgs.mitmproxy}/bin/mitmdump --set confdir=$out --version
    '';
in {
    security.pki.certificateFiles = [ "${ca}/mitmproxy-ca-cert.pem" ];

    systemd.services.nix-daemon-proxy = {
        description = "Proxy for nix-daemon";
        before = [ "nix-daemon.service" ];
        wantedBy = [ "multi-user.target" ];
        after = [ "network.target" ];

        serviceConfig = {
            ExecStart = "${pkgs.mitmproxy}/bin/mitmdump -s ${./nix_daemon_proxy.py} --listen-port 52207 --set confdir=${ca}";
            Restart = "on-failure";
            RestartSec = "3s";
        };
    };
}
