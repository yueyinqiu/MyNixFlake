{ config, lib, pkgs, ... }:
{
  imports = [
    ./mainland-proxy
    ./nix-daemon-proxy
    ./tongji-proxy
  ];

  config.home.packages = with pkgs; [
    sing-box
  ];

  options.my.sing-box.instances = lib.mkOption {
    type = lib.types.attrsOf (lib.types.listOf lib.types.path);
    default = { };
  };

  config = {
    xdg.configFile = lib.concatMapAttrs (instName: files:
      builtins.listToAttrs (
        map (file: {
          name = "sing-box/${instName}/${baseNameOf file}";
          value = { source = file; };
        }) files
      )
    ) config.my.sing-box.instances;

    systemd.user.services = lib.mapAttrs' (instName: files:
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
          ExecStart = ''"${pkgs.sing-box}/bin/sing-box" run -C "%h/.config/sing-box/${instName}"'';
          Restart = "on-failure";
          RestartSec = "5s";
        };
      }
    ) config.my.sing-box.instances;
  };
}