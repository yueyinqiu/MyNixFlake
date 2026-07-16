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
        
        "signon.rememberSignons" = false;
        "signon.autofillForms" = false;
      };

      extensions.packages = with nur.repos.rycee.firefox-addons; [
        bitwarden
      ];

      bookmarks = {
        force = true;
        settings = [
          {
            name = "PDF转JPG——免费在线PDF转成图片格式";
            url = "www.pdfdo.com/pdf-to-image.aspx";
          }
          {
            name = "Snappify";
            url = "https://snappify.com/dashboard";
          }
          {
            name = "SVG转换为PDF - 迅捷，在线，免费 - PDF24";
            url = "https://tools.pdf24.org/zh/svg-to-pdf";
          }
          {
            name = "在线免费文字转语音 - TTSMaker官网 | 马克配音";
            url = "https://ttsmaker.cn";
          }
          {
            name = "Snapmail";
            url = "https://snapmail.cc/#/emailList/levoczid@snapmail.cc";
          }
          {
            name = "Yijing Dao";
            url = "https://www.biroco.com/yijing/glossary.htm";
          }
          {
            name = "百度网盘空间站";
            url = "https://www.nccnxta.cn/pan/baidu";
          }
          {
            name = "微信公众平台";
            url = "https://mp.weixin.qq.com/";
          }
          {
            name = "TDoGMC Studio - 皮肤编辑器 | Minecraft皮肤制作 | 在线编辑，无需下载";
            url = "https://studio.tdogmc.cn/?lang=zh-CN";
          }
          {
            name = "Nix sites";
            toolbar = true;
            bookmarks = [
              {
                name = "微信开发者平台";
                url = "https://developers.weixin.qq.com/console/product/mp/wx01c09572ce8cefa2?tab1=basicInfo&tab2=apiMonitoring";
              }
              {
                name = "SakuraFrp";
                url = "https://www.natfrp.com/user/";
              }
              {
                name = "云盘 - 飞书云文档";
                url = "https://jcnljw0jyizz.feishu.cn/drive/me/";
              }
              {
                name = "随机端口生成器 - Random Port Generator - 查获 chahuo.com";
                url = "https://www.chahuo.com/random-port-generator.html";
              }
              {
                name = "NixOS Search - Packages";
                url = "https://search.nixos.org/packages";
              }
            ];
          }
        ];
      };
    };
  };
}
