{ config, pkgs, ... }: {
  imports = [
    ./nix-daemon-proxy
  ];
  home.packages = with pkgs; [
    sing-box
  ];

  my.r.sing-box = ''
    sing-box "$@"
  '';
  my.r.cd-sing-box-config = ''
    cd "${config.xdg.configHome}/sing-box"
    exec "$SHELL"
  '';
}
