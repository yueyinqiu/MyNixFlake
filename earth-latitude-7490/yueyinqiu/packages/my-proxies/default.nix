{ config, lib, pkgs, ... }:

let
  cfg = config.my.proxies;
  mmmm = pkgs.callPackage ./mihomo-manager-mihomo-mixin { };
  tui = pkgs.callPackage ./mihomo-tui { };
in
{
  options.my.proxies.mihomo = lib.mkOption {
    type = lib.types.attrsOf (lib.types.submodule {
      options = {
        port = lib.mkOption {
          type = lib.types.port;
        };
        files = lib.mkOption {
          type = lib.types.listOf lib.types.path;
        };
      };
    });
    default = { };
  };

  imports = [
    ./yeshayun
  ];

  config = {
    home.packages = [
      tui
    ];

    xdg.configFile = lib.mergeAttrsList (lib.mapAttrsToList (name: item:
      builtins.listToAttrs (map (file: {
        name = "mihomo/${name}/${baseNameOf file}";
        value = { source = file; };
      }) item.files)
    ) cfg.mihomo);

    systemd.user.services = lib.mapAttrs' (name: item:
      let
        port = pkgs.writeText "mihomo-${name}-port.yaml" ''
          mixed-port: ${toString item.port}
        '';

        runner = pkgs.writeShellScript "mihomo-run-${name}" ''
          set -e
          CONFIG_DIR="''${XDG_CONFIG_HOME:-$HOME/.config}/mihomo/${name}"

          . "$CONFIG_DIR/config.sh" "${mmmm}/bin/mmmm" /tmp/merged.yaml
          "${mmmm}/bin/mmmm" merge /tmp/merged.yaml merge "${port}" save config.yaml
          exec "${pkgs.mihomo}/bin/mihomo" -d . -ext-ctl-unix "''${XDG_RUNTIME_DIR}/mihomo-${name}.sock"
        '';
      in
      lib.nameValuePair "mihomo-${name}" {
        Unit = {
          Description = "mihomo Service (${name})";
          After = [ "network-online.target" ];
          Wants = [ "network-online.target" ];
        };
        Install.WantedBy = [ "default.target" ];
        Service = {
          ExecStart = ''${runner}'';
          Restart = "on-failure";
          RestartSec = "5s";
          PrivateTmp = true;
          StateDirectory = "mihomo/${name}";
          WorkingDirectory = "%S/mihomo/${name}";
        };
      }
    ) cfg.mihomo;

    my.navi-cheats.mihomo = ''
      $ name: ls "''${XDG_CONFIG_HOME:-$HOME/.config}/mihomo/"

      # open mihomo TUI dashboard, connecting to the selected my-proxies instance
      mihomo-tui -c <(echo "mihomo-api: unix:''${XDG_RUNTIME_DIR}/mihomo-<name>.sock")
    '';
  };
}
