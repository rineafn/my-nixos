{ palette, ... }:

{
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      command_timeout = 500;
      palette = "catppuccin_mocha";
      palettes.catppuccin_mocha = removeAttrs palette [ "raw" ];

      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
        vimcmd_symbol = "[❮](bold mauve)";
      };

      directory = {
        style = "bold blue";
        truncation_length = 3;
        truncation_symbol = "…/";
      };

      git_branch.style = "bold mauve";
      git_status.style = "bold peach";
      cmd_duration.style = "yellow";
      nix_shell.symbol = "󱄅 ";
    };
  };
}
