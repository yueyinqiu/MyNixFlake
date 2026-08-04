{
  pkgs,
  yueyinqiu-nur-packages,
  ...
}:
{
  home.packages = [
    pkgs.fzf
    yueyinqiu-nur-packages.snavi
  ];
}
