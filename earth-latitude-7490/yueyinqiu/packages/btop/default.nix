{ pkgs, ... }: {
  home.packages = with pkgs; [
    btop
  ];
  my.navi-cheats = [
    ''
      % btop

      # run btop, a resource monitor that shows usage and stats for processor, memory, disks, network and processes.
      btop
    ''
  ];
}
