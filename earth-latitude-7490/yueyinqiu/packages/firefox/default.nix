{ ... }: {
programs.firefox = {
  enable = true;

  profiles.default = {
    search.default = "bing";
    search.force = true;

    settings = {
      "browser.startup.homepage" = "about:blank";
      "browser.startup.page" = 0;

      "network.proxy.type" = 1;
      "network.proxy.socks" = "127.0.0.1";
      "network.proxy.socks_port" = 7890;
    };
  };
};
}
