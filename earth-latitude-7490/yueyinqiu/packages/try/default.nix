{
  ...
}:
{
  my.r.try = ''
    nix shell "nixpkgs#''${1}" "''${@:2}"
  '';
}
