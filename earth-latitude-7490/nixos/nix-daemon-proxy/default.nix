{ pkgs, lib, ... }:
{
    environment.systemPackages = [ 
        (pkgs.writeShellScriptBin "nix-daemon-proxy" ''
            echo "$1"
            echo "$1" | "${pkgs.socat}/bin/socat" - UNIX-CONNECT:/run/nix-daemon-proxy.sock
            echo "Check with: sudo cat /proc/$(pidof nix-daemon)/environ | tr '\0' '\n' | grep proxy"
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
            StandardOutput = "journal";
            StandardError = "journal";
            ExecStart = pkgs.writeShellScript "nix-daemon-proxy-switch-server" (''
                proxy=$("${pkgs.socat}/bin/socat" - fd:0)
                echo "Extracted proxy: $proxy"

                mkdir -p /run/systemd/system/nix-daemon.service.d/
                
                cat << EOF > /run/systemd/system/nix-daemon.service.d/override.conf
                [Service]
                Environment="all_proxy=$proxy"
                EOF

                systemctl daemon-reload
                systemctl restart nix-daemon --no-block
            '');
        };
    };
}
