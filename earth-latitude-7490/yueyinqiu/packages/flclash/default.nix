{ pkgs, ... }: {
    home.packages = with pkgs; [
        flclash
    ];
    my.r.flclash = "flclash";
}