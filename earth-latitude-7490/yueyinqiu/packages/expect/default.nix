{ pkgs, ... }: {
  home.packages = with pkgs; [
    expect

    (pkgs.writeShellApplication {
      name = "my-expect-bash-run";
      text = ''
        escaped="''${*@Q}"
        expect "${./bash-run.exp}" -- "$escaped"
      '';
    })
  ];

  my.navi-cheats.expect = ''
    # execute a command and leave the interactive bash session open
    my-expect-bash-run <command>
  '';
}
