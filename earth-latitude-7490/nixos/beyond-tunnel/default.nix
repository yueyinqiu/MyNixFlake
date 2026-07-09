{ config, lib, pkgs, ... }:
let
    pkg = pkgs.stdenv.mkDerivation {
        name = "beyond-tunnel";
        src = pkgs.fetchurl {
            url = "https://beyondtunnel.oss-cn-shenzhen.aliyuncs.com/edge_linux_amd64";
            hash = "";
        };
        dontUnpack = true;
        installPhase = ''
            install -m755 -D $src $out/bin/edge
        '';
    };
in {
    options.services.beyond-tunnel = {
        enable = lib.mkEnableOption "beyond-tunnel service";

        keyFile = lib.mkOption {
            type = lib.types.str;
            default = "/etc/beyond-tunnel/key";
            description = "Path to file containing EDGE_KEY environment variable";
        };
    };

    config = lib.mkIf config.services.beyond-tunnel.enable {
        assertions = [{
            assertion = builtins.pathExists config.services.beyond-tunnel.keyFile;
            message = ''
                beyond-tunnel: key file not found at ${config.services.beyond-tunnel.keyFile}.
                Run (as a privileged user):
                    mkdir -p "$(dirname "${config.services.beyond-tunnel.keyFile}")"
                    echo 'EDGE_KEY=your-key' > "${config.services.beyond-tunnel.keyFile}"
            '';
        }];
        environment.systemPackages = [ pkg ];

        systemd.services.beyond-tunnel = {
            description = "Beyond Tunnel Service";
            after = [ "network.target" ];
            wantedBy = [ "multi-user.target" ];

            serviceConfig = {
                ExecStart = "${pkg}/bin/edge";
                EnvironmentFile = config.services.beyond-tunnel.keyFile;
                Restart = "on-failure";
                RestartSec = "5s";
            };
        };
    };
}
