{ ... }: {
  programs.firefox = {
    enable = true;

    profiles.default = {
      search = {
        force = true;
        default = "bing";
      };

      settings = {
        "browser.startup.homepage" = "about:blank";
        "browser.startup.page" = 0;

        "network.proxy.type" = 1;
        "network.proxy.socks" = "127.0.0.1";
        "network.proxy.socks_port" = 7890;
      };

      bookmarks = {
        force = true;
        settings = [
          {
            name = "Bookmarks Toolbar";
            toolbar = true;
            bookmarks = [
              {
                name = "GitHub";
                url = "https://github.com";
              }
            ];
          }
        ];
      };
    };
  };
}
