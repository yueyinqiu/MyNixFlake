{ ... }: {
    programs.git = {
        enable = true;
        settings.user = {
            name  = "yueyinqiu";
            email = "yueyinqiu@outlook.com";
        };
        lfs.enable = true;
    };
}