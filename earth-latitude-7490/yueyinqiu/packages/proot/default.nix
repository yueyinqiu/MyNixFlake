{ pkgs, ... }: {
  home.packages = with pkgs; [
    proot
  ];

  my.proot = [
    ''
      % proot

      # run proot, a user-space implementation of chroot, mount --bind, and binfmt_misc.
      proot <args>
    ''
  ];
}