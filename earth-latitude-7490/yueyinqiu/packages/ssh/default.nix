{ pkgs, ... }: {
  programs.ssh.enable = true;

  my.r.ssh = ''
    ssh
  '';
}
