{ ... }:

{
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        type = "small";
        padding = {
          top = 1;
          left = 1;
          right = 2;
        };
      };
      display.separator = " ❯ ";
      modules = [
        {
          type = "title";
          color = {
            user = "blue";
            at = "white";
            host = "cyan";
          };
        }
        {
          type = "separator";
          string = "─";
        }
        {
          type = "os";
          key = "  os";
          keyColor = "blue";
        }
        {
          type = "kernel";
          key = "  kernel";
          keyColor = "cyan";
        }
        {
          type = "uptime";
          key = "󰅐  uptime";
          keyColor = "green";
        }
        {
          type = "packages";
          key = "󰏖  pkgs";
          keyColor = "yellow";
        }
        {
          type = "wm";
          key = "  wm";
          keyColor = "magenta";
        }
        {
          type = "terminal";
          key = "  term";
          keyColor = "red";
        }
        {
          type = "memory";
          key = "  memory";
          keyColor = "blue";
        }
        "break"
        {
          type = "colors";
          symbol = "circle";
        }
      ];
    };
  };
}
