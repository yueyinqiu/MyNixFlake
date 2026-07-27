{ pkgs, ... }: {
  home.packages = with pkgs; [
    expect
  ];

  my.r.expect-bash-run = ''
    escaped="''${*@Q}"
    expect "${./bash-run.exp}" -- "$escaped"
  '';
}
