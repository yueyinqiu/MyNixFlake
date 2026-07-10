{ pkgs, ... }: {
    home.packages = with pkgs; [
        mindustry
    ];
    services.flatpak.packages = [
        "com.github.Anuken.Mindustry"
    ];
    my.r.mindustry = "mindustry";
    my.r.mindustry-flatpak = "flatpak run com.github.Anuken.Mindustry";
}