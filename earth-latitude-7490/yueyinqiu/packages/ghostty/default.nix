{ pkgs, ... }: {
    home.packages = with pkgs; [
        ghostty
    ];
    my.r.ghostty = ''
        "${pkgs.ghostty}/bin/ghostty"
    '';
}