{ pkgs, ... }: {
    home.packages = with pkgs; [
        ghostty
    ];
    my.r.ghostty = "ghostty";
}