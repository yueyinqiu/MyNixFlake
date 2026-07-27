{ pkgs, ... }: {
  home.packages = with pkgs; [
    opencode
  ];

  my.navi-cheats = [
    ''
      % opencode

      # start a new opencode interactive session
      opencode
    ''
    ''
      % opencode

      # resume a specific opencode session
      opencode -s "<session>"
      $ session: opencode session list | grep '^ses_' --- --column 1
    ''
  ];
}
