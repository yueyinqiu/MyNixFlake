{ ... }: {
  programs.ssh.enable = true;
  programs.ssh.enableDefaultConfig = false;
  programs.ssh.settings = {
    "g3080-sakurafrp" = {
      hostname = "frp-bus.com";
      user = "yueyi";
      port = 65343;
      forwardAgent = true;
      addKeysToAgent = true;
    };
    "g3080-beyond-tunnel" = {
      hostname = "100.64.0.11";
      user = "yueyi";
      forwardAgent = true;
      addKeysToAgent = true;
    };

    "illusion" = {
      hostname = "192.168.216.132";
      user = "yueyinqiu";
      port = 10022;
      proxyJump = "g3080-beyond-tunnel";
      forwardAgent = true;
      addKeysToAgent = true;
    };
  };

  my.r.ssh = ''
    ssh "$@"
  '';
}
