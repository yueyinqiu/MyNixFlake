{ pkgs, lib, ... }:
{
    environment.systemPackages = [ 
        (pkgs.writeShellScriptBin "nix-daemon-proxy" ''
            echo "$1"
            echo "$1" | "${pkgs.socat}/bin/socat" - UNIX-CONNECT:/run/nix-daemon-proxy.sock
        '')
    ];

    users.groups.nix-daemon-proxy = {};

    systemd.sockets.nix-daemon-proxy-switch-server = {
        description = "Socket for nix-daemon-proxy";
        wantedBy = [ "sockets.target" ];
        listenStreams = [ "/run/nix-daemon-proxy.sock" ];
        socketConfig = {
            SocketMode = "0660";
            SocketGroup = "nix-daemon-proxy";
        };
    };

    systemd.services.nix-daemon-proxy-switch-server = {
        description = "Switch nix-daemon proxy";
        after = [ "nix-daemon.service" ];
        serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
            StandardInput = "socket";
            ExecStart = pkgs.writeShellScript "nix-daemon-proxy-switch-server" (builtins.readFile ./nix-daemon-proxy-switch-server.sh);
        };
    };
}
