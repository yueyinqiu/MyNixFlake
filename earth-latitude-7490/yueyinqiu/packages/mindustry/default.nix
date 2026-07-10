{ pkgs, ... }: {
    home.packages = with pkgs; [
        mindustry
    ];
    my.r.mindustry = "mindustry";
    
    # services.flatpak.packages = [
    #     "flathub:app/com.github.Anuken.Mindustry/x86_64/stable"
    # ];
    # my.r.mindustry-flatpak = "flatpak run com.github.Anuken.Mindustry";
}