{ config, pkgs, ... }: {
  imports = [
    ./nix-daemon-proxy
  ];

  my.r.sing-box = ''
    "${pkgs.sing-box}/bin/sing-box" "$@"
  '';
  my.r.cd-sing-box-config = ''
    cd "${config.xdg.configHome}/sing-box"
    exec "$SHELL"
  '';
}
