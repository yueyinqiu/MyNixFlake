{ pkgs, ... }: {
    home.packages = with pkgs; [
        mindustry
    ];
    my.r.mindustry = "mindustry";
}