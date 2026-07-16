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

        "browser.toolbars.bookmarks.visibility" = "always";
      };

      extensions.packages = with nur.repos.rycee.firefox-addons; [
        bitwarden
      ];

      bookmarks = {
        force = true;
        settings = [

          {
            name = "wikipedia";
            tags = [ "wiki" ];
            keyword = "wiki";
            url = "https://en.wikipedia.org/wiki/Special:Search?search=%s&go=Go";
          }
          {
            name = "kernel.org";
            url = "https://www.kernel.org";
          }
          "separator"
          {
            name = "Nix sites";
            toolbar = true;
            bookmarks = [
              {
                name = "homepage";
                url = "https://nixos.org/";
              }
              {
                name = "wiki";
                tags = [
                  "wiki"
                  "nix"
                ];
                url = "https://wiki.nixos.org/";
              }
            ];
          }
        ];
      };
    };
  };
}
