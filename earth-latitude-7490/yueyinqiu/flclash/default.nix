{ pkgs, ... }: {
    home.packages = with pkgs; [
        flclash
    ];
    my.run.entries.flclash = "flclash";
}