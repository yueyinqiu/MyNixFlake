{ config, lib, pkgs, ... }:
{
  imports = [
    ./mainland
    ./tongji
    ./nix-daemon-proxy
  ];

  config.home.packages = with pkgs; [
    sing-box
  ];

  options.my.sing-box.instances = lib.mkOption {
    type = lib.types.attrsOf (lib.types.submodule {
      options = {
        files = lib.mkOption {
          type = lib.types.listOf lib.types.path;
        };
        port = lib.mkOption {
          type = lib.types.int;
        };
        manager = lib.mkOption {
          type = lib.types.int;
        };
      };
    });
    default = { };
  };

  config = {
    xdg.configFile = lib.concatMapAttrs (name: cfg:
      (builtins.listToAttrs (
        map (file: {
          name = "sing-box/${name}/${baseNameOf file}";
          value = { source = file; };
        }) cfg.files
      )) // {
        "sing-box/${name}/config.json" = {
          text = builtins.toJSON {
            inbounds = [
              {
                type = "mixed";
                tag = "mixed-in";
                listen = "127.0.0.1";
                listen_port = cfg.port;
              }
            ];
            experimental = {
              clash_api = {
                external_controller = "127.0.0.1:${toString cfg.manager}";
              };
            };
          };
        };
      }
    ) config.my.sing-box.instances;

    systemd.user.services = lib.mapAttrs' (instName: cfg:
      lib.nameValuePair "sing-box-${instName}" {
        Unit = {
          Description = "sing-box Service (${instName})";
          After = [ "network-online.target" ];
          Wants = [ "network-online.target" ];
        };
        Install = {
          WantedBy = [ "default.target" ];
        };
        Service = {
          ExecStart = ''"${pkgs.sing-box}/bin/sing-box" run -C "%h/.config/sing-box/${instName}" -D "%h/.config/sing-box/${instName}"'';
          Restart = "on-failure";
          RestartSec = "5s";
        };
      }
    ) config.my.sing-box.instances;

    my.r = lib.mapAttrs' (instName: cfg:
      lib.nameValuePair "sing-box-${instName}" ''
        echo "sing-box instance: ${instName}"
        echo "  mixed port:     ${toString cfg.port}"
        echo "  clash api port: ${toString cfg.manager}"
        echo ""
        echo "manage:"
        echo "  systemctl --user start sing-box-${instName}"
        echo "  systemctl --user stop sing-box-${instName}"
        echo "  systemctl --user status sing-box-${instName}"
        echo "  journalctl --user -u sing-box-${instName}"
      ''
    ) config.my.sing-box.instances;
  };
}
