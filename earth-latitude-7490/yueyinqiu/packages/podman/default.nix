{ pkgs, ... }: {
  my.r.podman = ''
    podman "$@"
  '';
  my.r.podman-compose = ''
    "${pkgs.podman-compose}/bin/podman-compose" "$@"
  '';
}
