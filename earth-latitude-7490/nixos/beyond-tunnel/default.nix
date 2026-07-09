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
        environment.systemPackages = [ pkg ];

        systemd.services.beyond-tunnel = {
            description = "Beyond Tunnel Service";
            after = [ "network.target" ];
            wantedBy = [ "multi-user.target" ];

            serviceConfig = {
                ExecStart = "${pkg}/bin/edge";
                ExecStartPre = [
                    (pkgs.writeShellScript "beyond-tunnel-key-check" ''
                        keyFile="${config.services.beyond-tunnel.keyFile}"
                        if [ ! -f "$keyFile" ]; then
                            echo "beyond-tunnel: key file not found at $keyFile" >&2
                            echo "Run:" >&2
                            echo "    sudo mkdir -p \"$(dirname "$keyFile")\"" >&2
                            echo "    echo 'EDGE_KEY=your-key' | sudo tee \"$keyFile\"" >&2
                            exit 1
                        fi
                    '')
                ];
                EnvironmentFile = config.services.beyond-tunnel.keyFile;
                Restart = "on-failure";
                RestartSec = "5s";
            };
        };
    };
}
