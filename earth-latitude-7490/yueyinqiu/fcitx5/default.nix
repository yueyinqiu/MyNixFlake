{ ... }: {
    i18n.inputMethod.fcitx5.settings.inputMethod = {
        GroupOrder."0" = "Default";
        "Groups/0" = {
            Name = "Default";
            "Default Layout" = "cn-altgr-pinyin";
            DefaultIM = "keyboard-us";
        };
        "Groups/0/Items/0".Name = "pinyin";
        "Groups/0/Items/1".Name = "keyboard-us";
    };
    # i18n.inputMethod.fcitx5.settings.globalOptions = { };
    i18n.inputMethod.fcitx5.ignoreUserConfig = true;
}
