{ pkgs, ... }: {
    my.r.office = ''
        "${pkgs.onlyoffice-desktopeditors}/bin/onlyoffice-desktopeditors"
    '';

    # 字体手动复制到 ~/.local/share/fonts 吧。因为肯定还想要一些 windows 下的字体，这个没版权不能二次发布的（只能下载 Windows 的 ISO 然后取字体……这也太蠢了）。

    # home.activation.copyCorefonts = lib.hm.dag.entryAfter [ "writeBoundary" "installPackages" ] ''
    #     mkdir -p ~/.local/share/fonts
    #     cp -u ${pkgs.corefonts}/share/fonts/truetype/* ~/.local/share/fonts/
    #     chmod 644 ~/.local/share/fonts/*
    # '';
}
