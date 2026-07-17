{ pkgs, ... }: {
  home.packages = with pkgs; [
    microsoft-edge
  ];

  my.r.edge = ''
    microsoft-edge --proxy-server=localhost:7890
  '';
}
