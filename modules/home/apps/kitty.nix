{ ... }:

{
  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Mocha";
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 11;
    };
    settings = {
      window_padding_width = 16;
      background_opacity = "0.85";
      scrollback_lines = 10000;
      copy_on_select = "clipboard";
      confirm_os_window_close = 0;

      cursor_shape = "block";
      cursor_blink_interval = "0.5";
      cursor_stop_blinking_after = "15.0";

      enable_audio_bell = false;
    };
  };
}
