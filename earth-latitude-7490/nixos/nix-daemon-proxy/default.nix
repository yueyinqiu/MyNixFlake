{ config, lib, pkgs, ... }:
let
    certificates = pkgs.runCommand "nix-daemon-proxy-certificates" { } ''
        mkdir -p $out
        ${pkgs.openssl}/bin/openssl req -x509 -newkey rsa:2048 -nodes \
            -keyout $out/key.key -out $out/pem.pem -days 3650 \
            -subj "/CN=nix-daemon-proxy-certificates"
    '';
in {
    security.pki.certificateFiles = [ "${certificates}/pem.pem" ];

    systemd.services.github-proxy = {
        description = "Proxy for nix-daemon";
        before = [ "nix-daemon.service" ];
        wantedBy = [ "multi-user.target" ];
        after = [ "network.target" ];

        serviceConfig = {
            ExecStart = "${pkgs.mitmproxy}/bin/mitmdump -s ${./nix_daemon_proxy.py} --listen-port 52207 --certs ${certificates}/pem.pem=${certificates}/key.key";
            Restart = "on-failure";
            RestartSec = "3s";
        };
    };
}
