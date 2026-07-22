{ pkgs, ... }: {
  programs.ssh.enable = true;
  programs.ssh.enableDefaultConfig = false;

  my.r.ssh = ''
    ssh
  '';
}
