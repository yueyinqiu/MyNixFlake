{ pkgs, ... }: {
    my.r.podman-compose = ''
        "${pkgs.podman-compose}/bin/podman-compose"
    '';
}
