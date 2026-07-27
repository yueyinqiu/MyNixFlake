{ ... }: {
  services.mako.enable = true;
  my.navi-cheats = [
    ''
      % mako

      # view recent mako notification history
      makoctl history -j
    ''
  ];
}
