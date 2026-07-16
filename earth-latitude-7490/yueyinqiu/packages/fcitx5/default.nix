{ pkgs, ... }: {
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      qt6Packages.fcitx5-chinese-addons
    ];
    fcitx5.settings.inputMethod = {
      GroupOrder."0" = "Default";
      "Groups/0" = {
        Name = "Default";
        "Default Layout" = "cn-altgr-pinyin";
        DefaultIM = "keyboard-us";
      };
      "Groups/0/Items/0".Name = "pinyin";
      "Groups/0/Items/1".Name = "keyboard-us";
    };
    fcitx5.settings.addons = {
      cloudpinyin = {
        globalSection = {
          Backend = "Baidu";
          MinimumPinyinLength = "2";
        };
      };
      pinyin = {
        globalSection = {
          CloudPinyinEnabled = true;
        };
      };
    };
    fcitx5.ignoreUserConfig = true;
    fcitx5.waylandFrontend = true;
  };
}
