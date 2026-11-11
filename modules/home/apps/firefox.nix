{ ... }:

{
  programs.firefox = {
    enable = true;
    configPath = ".mozilla/firefox";
    profiles.default.settings = {
      "ui.systemUsesDarkTheme" = 1;
      "browser.theme.dark" = true;
      "layout.css.prefers-color-scheme.content" = 0;
    };
  };
}
