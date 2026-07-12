{ pkgs, ... }: {
    home.packages = with pkgs; [
        onlyoffice-desktopeditors
    ];
    my.r.office = "onlyoffice-desktopeditors";
}
