{ pkgs, lib, ... }:
{
    environment.systemPackages = [ 
        (pkgs.writeShellScriptBin "nix-daemon-proxy" ''
            PROXY=$(${pkgs.jq}/bin/jq -rn --arg val "$1" '$val | @uri')
            ${pkgs.curl}/bin/curl --unix-socket /run/nix-daemon-proxy.sock -i -X POST "http://localhost/?proxy=$1"
            echo 'Check with: sudo cat /proc/$(pidof nix-daemon)/environ | tr "\0" "\n" | grep proxy'
        '')
    ];

    users.groups.nix-daemon-proxy = {};

    systemd.services.nix-daemon-proxy-switch-server = {
        description = "nix-daemon-proxy Switch Server";
        wantedBy = [ "multi-user.target" ];

        serviceConfig = {
            # direct `dotnet run server.cs` will cause MSB3552
            # might (not verified) be releated to https://github.com/dotnet/msbuild/issues/12546
            ExecStart = (pkgs.writeShellScript "nix-daemon-proxy-switch-server" ''
                PROJECT=$("${pkgs.coreutils}/bin/mktemp" -u)
                ${pkgs.dotnetCorePackages.sdk_10_0}/bin/dotnet project convert ${./server.cs} --output "$PROJECT" --interactive False
                ${pkgs.dotnetCorePackages.sdk_10_0}/bin/dotnet run --project "$PROJECT" 
            '');
            PrivateTmp = true;
            Restart = "on-failure";
            RestartSec = "5s";
        };
    };
}
