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
            # direct `dotnet run server.cs` will cause MSB3552
            # might (not verified) be releated to https://github.com/dotnet/msbuild/issues/12546
            ExecStart = ''
                PROJECT=$("${pkgs.coreutils}/bin/mktemp")
                ${pkgs.dotnetCorePackages.sdk_10_0}/bin/dotnet project convert ${./server.cs} --output "$PROJECT" --interactive False
                ${pkgs.dotnetCorePackages.sdk_10_0}/bin/dotnet run --project "$PROJECT" 
            '';
            PrivateTmp = true;
            Restart = "on-failure";
            RestartSec = "5s";
        };
    };
}
