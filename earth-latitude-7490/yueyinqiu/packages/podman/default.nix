{ pkgs, ... }: {
  home.packages = with pkgs; [
    podman-compose
  ];

  my.navi-cheats = [
    ''
      % podman

      # run podman, a daemonless container engine that lets you manage containers, pods, and images.
      podman <args>
    ''
  ];
}
