{ ... }:
{
  my.proxies.for-nix-daemon = {
    files = [
      ./config.sh.example
      ./rules.yaml
    ];
    port = 26290;
  };

  systemd.user.services.nix-daemon-proxy = {
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
      ExecStart = "/run/current-system/sw/bin/nix-daemon-proxy socks5h://127.0.0.1:26290";
      Restart = "on-failure";
      RestartSec = "5s";
      StartLimitIntervalSec = 300;
      StartLimitBurst = 60;
    };
  };
}
