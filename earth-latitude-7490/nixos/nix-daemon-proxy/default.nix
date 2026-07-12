{ config, lib, pkgs, ... }:
let
    certificates = pkgs.runCommand "nix-daemon-proxy-certificates" { } ''
        mkdir -p $out
        ${pkgs.openssl}/bin/openssl req -x509 -newkey rsa:2048 -nodes \
            -keyout $out/key.pem -out $out/cert.pem -days 3650 \
            -subj "/CN=nix-daemon-proxy-certificates"
        cat $out/cert.pem $out/key.pem > $out/ca.pem
    '';
in {
    security.pki.certificateFiles = [ "${certificates}/cert.pem" ];

    systemd.services.github-proxy = {
        description = "Proxy for nix-daemon";
        before = [ "nix-daemon.service" ];
        wantedBy = [ "multi-user.target" ];
        after = [ "network.target" ];

        serviceConfig = {
            ExecStart = "${pkgs.mitmproxy}/bin/mitmdump -s ${./nix_daemon_proxy.py} --listen-port 52207 --certs ${certificates}/ca.pem";
            Restart = "on-failure";
            RestartSec = "3s";
        };
    };
}
