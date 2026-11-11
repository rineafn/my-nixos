{
  config,
  palette,
  pkgs,
  ...
}:

let
  rofi-wallpaper = pkgs.writeShellApplication {
    name = "rofi-wallpaper";
    runtimeInputs = [
      pkgs.coreutils
      pkgs.feh
      pkgs.findutils
      pkgs.libnotify
      config.programs.rofi.package
    ];
    text = ''
      wall_dir="$HOME/Pictures/wallpaper"
      mkdir -p "$wall_dir"

      files=$(find "$wall_dir" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' \) ! -name 'current.jpg' -printf '%f\n')

      if [ -z "$files" ]; then
        notify-send "Wallpaper Picker" "There is no wallpaper in $wall_dir"
        exit 1
      fi

      selected=$(printf '%s\n' "$files" | rofi -dmenu -p "Pick Wallpaper" -i || true)

      if [ -n "$selected" ]; then
        feh --bg-fill "$wall_dir/$selected"
        ln -sf "$wall_dir/$selected" "$wall_dir/current.jpg"
        notify-send "Wallpaper Picker" "Wallpaper changed to $selected"
      fi
    '';
  };
in
{
  home.packages = [ rofi-wallpaper ];

  xdg.configFile."rofi/theme.rasi".text = ''
    * {
        bg: ${palette.base}e6;
        bg-alt: ${palette.surface0}e6;
        fg: ${palette.text};
        accent: ${palette.mauve};

        background-color: transparent;
        text-color: @fg;
    }

    window {
        width: 520px;
        padding: 24px;
        background-color: @bg;
        border-radius: 24px;
        border: 0px;
    }

    inputbar {
        children: [prompt, entry];
        margin: 0 0 16px 0;
        padding: 12px 16px;
        background-color: @bg-alt;
        border-radius: 12px;
    }

    prompt {
        text-color: @accent;
        font: "Symbols Nerd Font 14";
        padding: 0 8px 0 0;
        str: "󰍉 ";
    }

    entry {
        placeholder: "Find...";
        placeholder-color: ${palette.overlay0};
    }

    listview {
        lines: 8;
        columns: 1;
        scrollbar: false;
    }

    element {
        padding: 12px;
        border-radius: 12px;
        margin: 2px 0;
    }

    element selected {
        background-color: @accent;
        text-color: @bg;
    }

    element-icon {
        size: 24px;
        padding: 0 8px 0 4px;
    }

    element-text {
        font: "JetBrainsMono Nerd Font 11";
    }
  '';

  programs.rofi = {
    enable = true;
    theme = "theme";
    settings = {
      modi = "drun,run,window";
      font = "JetBrainsMono Nerd Font 12";
      show-icons = true;
      location = 0;
      icon-theme = "Papirus-Dark";
    };
  };
}
