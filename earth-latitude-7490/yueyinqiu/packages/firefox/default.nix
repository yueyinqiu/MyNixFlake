{ nur, ... }: {
  programs.firefox = {
    enable = true;

    profiles.default = {
      name = "default";

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
        "browser.download.autohideButton" = false;
        "browser.aboutConfig.showWarning" = false;
        
        "browser.uiCustomization.state" = builtins.readFile ./ui.json;
      };

      extensions.packages = with nur.repos.rycee.firefox-addons; [
        bitwarden
      ];

      bookmarks = {
        force = true;
        settings = [
          {
            name = "wikipedia";
            url = "https://en.wikipedia.org/wiki/Special:Search?search=%s&go=Go";
          }
          {
            name = "kernel.org";
            url = "https://www.kernel.org";
          }
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
                url = "https://wiki.nixos.org/";
              }
            ];
          }
        ];
      };
    };
  };
}
