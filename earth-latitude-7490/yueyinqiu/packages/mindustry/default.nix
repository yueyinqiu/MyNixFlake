{ pkgs, ... }: {
    home.packages = with pkgs; [
        mindustry
    ];
    my.r.mindustry = "mindustry";
    
    services.flatpak.packages = [
        "com.github.Anuken.Mindustry"
    ];
    my.r.mindustry-flatpak = "flatpak run com.github.Anuken.Mindustry";
}