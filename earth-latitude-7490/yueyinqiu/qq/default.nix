{ pkgs, ... }: {
    home.packages = with pkgs; [
        qq
    ];
    my.run.entries.qq = "qq";
}