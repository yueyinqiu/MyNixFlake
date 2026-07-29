{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.my.proxies;
  mmmm = pkgs.callPackage ./mihomo-manager-mihomo-mixin { };
  tui = pkgs.callPackage ./mihomo-tui { };
in
{
  options.my.proxies.mihomo = lib.mkOption {
    type = lib.types.attrsOf (
      lib.types.submodule {
        options = {
          port = lib.mkOption {
            type = lib.types.port;
          };
          files = lib.mkOption {
            type = lib.types.listOf lib.types.path;
          };
        };
      }
    );
    default = { };
  };

  imports = [
    ./ye-sha-yun
  ];

  config = {
    home.packages = [
      pkgs.mihomo
      mmmm
      tui
    ];

    xdg.configFile = lib.mergeAttrsList (
      lib.mapAttrsToList (
        name: item:
        builtins.listToAttrs (
          map (file: {
            name = "my-proxies/${name}/${baseNameOf file}";
            value = {
              source = file;
            };
          }) item.files
        )
      ) cfg.mihomo
    );

    systemd.user.services = lib.mapAttrs' (
      name: item:
      let
        port = pkgs.writeText "my-proxies-${name}-port.yaml" ''
          mixed-port: ${toString item.port}
        '';

        runner = pkgs.writeShellScript "my-proxies-run-${name}" ''
          set -e

          cd "''${XDG_CONFIG_HOME:-$HOME/.config}/my-proxies/${name}"
          mkdir -p "/tmp/config-sh"
          mkdir -p "$STATE_DIRECTORY/config-sh"
          MMMM="${mmmm}/bin/mmmm" \
            OUTPUT_PATH="/tmp/merged.yaml" \
            TEMP_DIRECTORY="/tmp/config-sh" \
            STATE_DIRECTORY="$STATE_DIRECTORY/config-sh" \
            bash config.sh

          "${mmmm}/bin/mmmm" merge /tmp/merged.yaml merge "${port}" save config.yaml

          SOCKET="$XDG_RUNTIME_DIR/my-proxies-${name}.sock"

          mkdir -p "$STATE_DIRECTORY/tui"
          cd "$STATE_DIRECTORY/tui"
          cat > config.yaml << EOF
          mihomo-api: unix:$SOCKET
          EOF

          mkdir -p "$STATE_DIRECTORY/core"
          cd "$STATE_DIRECTORY/core"
          exec "${pkgs.mihomo}/bin/mihomo" -d . -ext-ctl-unix "$SOCKET"
        '';
      in
      lib.nameValuePair "my-proxies-${name}" {
        Unit = {
          Description = "my-proxies Service ${name}";
          After = [ "network-online.target" ];
          Wants = [ "network-online.target" ];
        };
        Install.WantedBy = [ "default.target" ];
        Service = {
          ExecStart = "${runner}";
          Restart = "on-failure";
          RestartSec = "5s";
          PrivateTmp = true;
          StateDirectory = "my-proxies/state/${name}";
        };
      }
    ) cfg.mihomo;

    my.navi-cheats.my-proxies = ''
      $ name: ls "''${XDG_CONFIG_HOME:-$HOME/.config}/my-proxies/"

      # open mihomo-tui dashboard, connecting to the selected my-proxies instance
      mihomo-tui -c "''${XDG_STATE_HOME:-$HOME/.local/state}/my-proxies/state/<name>/tui/config.yaml"
    '';
  };
}
