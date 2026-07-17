{ pkgs, ... }: {
  home.packages = with pkgs; [
    podman-compose
  ];

  my.r.podman = ''
    podman "$@"
  '';
  my.r.podman-compose = ''
    podman-compose "$@"
  '';
}
