{ ... }:
{
  my.sing-box.instances.for-nix-daemon = {
    files = [
      ./rules.json
    ];
    port = 23569;
    manager = 62751;
  };

  systemd.user.services.proxy-for-nix-daemon = {
    Unit = {
      Description = "Set nix-daemon proxy";
      After = [ "sing-box-nix-daemon.service" ];
      Wants = [ "sing-box-nix-daemon.service" ];
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      Type = "oneshot";
      ExecStart = "/run/current-system/sw/bin/nix-daemon-proxy socks5h://127.0.0.1:23569";
      Restart = "on-failure";
      RestartSec = "5s";
      StartLimitIntervalSec = 300;
      StartLimitBurst = 60;
    };
  };

  my.r.proxy-for-nix-daemon-switch = ''
    nix-daemon-proxy socks5h://127.0.0.1:23569
  '';

  my.r.proxy-for-nix-daemon-check-block = ''
    journalctl --user -u sing-box-for-nix-daemon | grep block
  '';

  my.r.proxy-for-nix-daemon-restart = ''
    systemctl --user restart sing-box-for-nix-daemon
  '';
}
