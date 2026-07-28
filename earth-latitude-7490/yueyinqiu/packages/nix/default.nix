{
  ...
}:
{
  my.navi-cheats.nix = ''
    $ package: printf "nixpkgs#git\nnixpkgs#btop\n" --- --map my-bash-escape-std

    # try a nix package
    nix shell <package>
  '';
}
