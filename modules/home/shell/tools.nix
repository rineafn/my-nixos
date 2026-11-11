{ palette, ... }:

{
  programs = {
    atuin = {
      enable = true;
      flags = [ "--disable-up-arrow" ];
      settings = {
        style = "compact";
        inline_height = 20;
      };
    };

    bat = {
      enable = true;
      config.style = "numbers,changes";
    };

    btop = {
      enable = true;
      settings = {
        theme_background = false;
        vim_keys = true;
      };
    };

    direnv = {
      enable = true;
      silent = true;
      nix-direnv.enable = true;
    };

    eza = {
      enable = true;
      extraOptions = [
        "--group-directories-first"
        "--icons=auto"
      ];
    };

    fzf = {
      enable = true;
      historyWidget.fish.command = "";
      defaultOptions = [
        "--height=40%"
        "--layout=reverse"
        "--border"
      ];
      colors = {
        bg = palette.base;
        "bg+" = palette.surface0;
        fg = palette.text;
        "fg+" = palette.text;
        hl = palette.mauve;
        "hl+" = palette.mauve;
        header = palette.mauve;
        info = palette.blue;
        marker = palette.green;
        pointer = palette.red;
        prompt = palette.mauve;
        spinner = palette.peach;
      };
    };

    lazygit.enable = true;

    yazi = {
      enable = true;
      shellWrapperName = "y";
      enableFishIntegration = true;
    };

    zoxide.enable = true;
  };
}
