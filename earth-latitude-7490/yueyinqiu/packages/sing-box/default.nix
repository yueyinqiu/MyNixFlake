{ pkgs, ... }: {
    imports = [
        ./nixos-rebuild-proxy
    ];

    home.packages = with pkgs; [
        sing-box
    ];
}
