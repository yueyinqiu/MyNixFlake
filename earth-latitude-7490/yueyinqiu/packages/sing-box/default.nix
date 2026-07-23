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
            outbounds = [
              {
                type = "socks";
                tag = "mainland";
                server = "127.0.0.1";
                server_port = 29662;
              }
              {
                type = "socks";
                tag = "tongji";
                server = "127.0.0.1";
                server_port = 54372;
              }
              {
                type = "direct";
                tag = "direct";
              }
              {
                type = "block";
                tag = "block";
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
        echo "  proxy:"
        echo "    export all_proxy=socks5h://127.0.0.1:${toString cfg.port}"
        echo "  manage:"
        echo "    https://metacubex.github.io/metacubexd/#/setup?http=true&hostname=127.0.0.1&port=${toString cfg.manager}"
        echo "    systemctl --user status sing-box-${instName}"
        echo "    systemctl --user restart sing-box-${instName}"
        echo "    journalctl --user -u sing-box-${instName}"
      ''
    ) config.my.sing-box.instances;
  };
}
