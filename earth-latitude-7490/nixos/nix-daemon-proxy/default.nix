{ pkgs, lib, ... }:
{
    environment.systemPackages = [ 
        (pkgs.writeShellScriptBin "nix-daemon-proxy" ''
            ${pkgs.curl}/bin/curl --unix-socket /run/nix-daemon-proxy.sock -X POST --data-urlencode "proxy=$1" "http://localhost/"
            echo "Check with: sudo cat /proc/$(pidof nix-daemon)/environ | tr '\0' '\n' | grep proxy"
        '')
    ];

    users.groups.nix-daemon-proxy = {};

    systemd.services.nix-daemon-proxy-switch-server = {
        description = "nix-daemon-proxy Switch Server";
        wantedBy = [ "multi-user.target" ];

        serviceConfig = {
            ExecStart = "${pkgs.dotnetCorePackages.sdk_10_0}/bin/dotnet run ${./server.cs}";
            Restart = "on-failure";
            RestartSec = "5s";
        };
    };
}
