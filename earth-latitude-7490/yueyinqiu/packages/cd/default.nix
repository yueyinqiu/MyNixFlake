{
  ...
}:
{
  my.r.cd-p = ''
    cd ~/MyProjects
    exec "$SHELL"
  '';
  my.r.cd-m = ''
    cd ~/MyMiscellaneousFiles
    exec "$SHELL"
  '';
  my.r.cd-t = ''
    cd ~/MyTemporaryFiles
    exec "$SHELL"
  '';
  my.r.cd-os = ''
    cd ~/MyProjects/Nix/MyNixFlake
    exec "$SHELL"
  '';
  my.r.cd-notes = ''
    cd ~/MyMiscellaneousFiles/Notes
    exec "$SHELL"
  '';
}
