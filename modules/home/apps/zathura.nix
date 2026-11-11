{ palette, ... }:

{
  programs.zathura = {
    enable = true;
    options = {
      selection-clipboard = "clipboard";
      recolor = true;
      recolor-keephue = true;
      default-bg = palette.base;
      default-fg = palette.text;
      recolor-darkcolor = palette.text;
      recolor-lightcolor = palette.base;
      statusbar-bg = palette.mantle;
      statusbar-fg = palette.text;
      inputbar-bg = palette.mantle;
      inputbar-fg = palette.text;
    };
  };
}
