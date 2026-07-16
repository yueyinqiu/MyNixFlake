{ nur, ... }: {
  programs.firefox = {
    enable = true;

    profiles.default = {
      search = {
        force = true;
        default = "bing";
      };

      settings = {
        "browser.startup.homepage" = "https://outlook.live.com/mail/";
        "browser.startup.page" = 1;

        "network.proxy.type" = 1;
        "network.proxy.socks" = "127.0.0.1";
        "network.proxy.socks_port" = 7890;
      };

      extensions.packages = with nur.repos.rycee.firefox-addons; [
        bitwarden
      ];

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
