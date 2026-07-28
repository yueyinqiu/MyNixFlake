{ ... }: {
  programs.fuzzel.enable = true;
  my.navi-cheats.fuzzel = ''
    # run fuzzel, a Wayland-native application launcher and fuzzy finder, inspired by rofi and dmenu.
    fuzzel
  '';
}
