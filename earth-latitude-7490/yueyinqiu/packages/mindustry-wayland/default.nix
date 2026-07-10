{ pkgs, ... }: {
    home.packages = with pkgs; [
        mindustry-wayland
    ];
    my.r.mindustry = "mindustry";
}