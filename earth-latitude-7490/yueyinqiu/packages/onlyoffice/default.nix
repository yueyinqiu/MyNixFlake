{ pkgs, lib, ... }: {
    home.packages = with pkgs; [
        onlyoffice-desktopeditors
    ];
    my.r.office = "onlyoffice-desktopeditors";

    home.activation.copyCorefonts = lib.hm.dag.entryAfter [ "writeBoundary" "installPackages" ] ''
        mkdir -p ~/.local/share/fonts
        cp -u ${pkgs.corefonts}/share/fonts/truetype/* ~/.local/share/fonts/
        chmod 644 ~/.local/share/fonts/*
    '';
}
