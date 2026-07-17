{ pkgs, ... }: {
  home.packages = with pkgs; [
    expect
  ];

  my.r.expect = ''
    expect "$@"
  '';
}
