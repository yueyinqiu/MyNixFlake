{ pkgs, ... }: {
  home.packages = with pkgs; [
    expect
  ];

  my.r.expect-bash-run = ''
    escaped="''${*@Q}"
    expect "${./bash-run.exp}" -- "$escaped"
  '';

  my.navi-cheats = [
    ''
      % expect, bash

      # execute a command and leave the interactive bash session open
      r expect-bash-run <command>
    ''
  ];
}
