{ config, lib, pkgs, ... }:

let
  cfg = config.my.proxies;

  mihomoMixin = pkgs.callPackage ./mihomo-manager-mihomo-mixin { };
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

  config = {
    xdg.configFile = lib.foldl' lib.recursiveUpdate { } (lib.mapAttrsToList (name: inst:
      builtins.listToAttrs (map (file: {
        name = "mihomo/${name}/${baseNameOf file}";
        value = { source = file; };
      }) inst.files)
    ) cfg.mihomo);

    systemd.user.services = lib.mapAttrs' (name: inst:
      let
        portYaml = pkgs.writeText "mihomo-${name}-port.yaml" ''
          mixed-port: ${toString inst.port}
        '';

        runner = pkgs.writeShellScript "mihomo-run-${name}" ''
          set -e
          CONFIG_DIR="''${XDG_CONFIG_HOME:-$HOME/.config}/mihomo/${name}"

          . "$CONFIG_DIR/config.sh" "${mihomoMixin}/bin/mmmm" /tmp/merged.yaml
          "${mihomoMixin}/bin/mmmm" merge /tmp/merged.yaml merge "${portYaml}" save config.yaml
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
      $ name: find "''${XDG_CONFIG_HOME:-$HOME/.config}/mihomo/" -maxdepth 1 -type d --- --map my-bash-escape-std

      # Open TUI dashboard
      mihomo-tui -c <(echo "mihomo-api: unix:''${XDG_RUNTIME_DIR}/mihomo-<name>.sock")
    '';
  };
}
