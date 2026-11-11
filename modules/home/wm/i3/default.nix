{
  lib,
  palette,
  pkgs,
  ...
}:

let
  mod = "Mod4";

  lock-screen = pkgs.writeShellApplication {
    name = "lock-screen";
    runtimeInputs = [ pkgs.i3lock-color ];
    text = ''
      exec i3lock \
        --blur 5 \
        --clock \
        --indicator \
        --time-str="%H:%M:%S" \
        --date-str="%A, %B %d" \
        --inside-color=${palette.raw.base}80 \
        --ring-color=${palette.raw.mauve} \
        --line-color=00000000 \
        --keyhl-color=${palette.raw.blue} \
        --ringver-color=${palette.raw.green} \
        --insidever-color=${palette.raw.base}80 \
        --ringwrong-color=${palette.raw.red} \
        --insidewrong-color=${palette.raw.base}80 \
        --text-color=${palette.raw.text} \
        --time-color=${palette.raw.text} \
        --date-color=${palette.raw.subtext1} \
        --layout-color=00000000 \
        --verif-color=${palette.raw.green} \
        --wrong-color=${palette.raw.red} \
        --greeter-color=${palette.raw.mauve} \
        --time-font="JetBrainsMono Nerd Font" \
        --date-font="JetBrainsMono Nerd Font" \
        --layout-font="JetBrainsMono Nerd Font" \
        --verif-font="JetBrainsMono Nerd Font" \
        --wrong-font="JetBrainsMono Nerd Font" \
        --radius=120 \
        --ring-width=12 \
        --nofork \
        --screensaver
    '';
  };

  borderColors = border: background: text: {
    inherit border background text;
    indicator = border;
    childBorder = border;
  };

  power-mode = ''mode "default"'';
in
{
  imports = [ ./polybar.nix ];

  home.packages = [ lock-screen ];

  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = mod;
      bars = [ ];

      fonts = {
        names = [ "JetBrainsMono Nerd Font" ];
        size = 10.0;
      };

      gaps = {
        inner = 10;
        outer = 5;
      };

      window = {
        border = 2;
        titlebar = false;
      };

      colors = {
        focused = borderColors palette.blue palette.blue palette.base;
        focusedInactive = borderColors palette.surface0 palette.surface0 palette.text;
        unfocused = borderColors palette.base palette.base palette.text;
        urgent = borderColors palette.red palette.red palette.base;
      };

      startup = [
        {
          command = "feh --bg-fill ~/Pictures/wallpaper/current.jpg || feh --bg-fill ~/Pictures/wallpaper/1.jpg || feh --bg-solid '${palette.base}'";
          always = true;
          notification = false;
        }
        {
          command = "polybar-launch";
          always = true;
          notification = false;
        }
        {
          command = "${pkgs.eww}/bin/eww daemon";
          always = false;
          notification = false;
        }
        {
          command = "${pkgs.xss-lock}/bin/xss-lock --transfer-sleep-lock -- lock-screen";
          always = false;
          notification = false;
        }
      ];

      modes = {
        power_menu = {
          "s" = "exec systemctl poweroff, ${power-mode}";
          "r" = "exec systemctl reboot, ${power-mode}";
          "z" = "exec systemctl suspend, exec eww close-all, ${power-mode}";
          "l" = "exec lock-screen, exec eww close-all, ${power-mode}";
          "e" = "exec i3-msg exit, ${power-mode}";
          "Escape" = "exec eww close-all, ${power-mode}";
          "Return" = power-mode;
        };
        widget_mode = {
          "Escape" = "exec eww close-all, ${power-mode}";
          "Return" = power-mode;
        };
        resize = {
          "h" = "resize shrink width 10 px or 10 ppt";
          "j" = "resize grow height 10 px or 10 ppt";
          "k" = "resize shrink height 10 px or 10 ppt";
          "l" = "resize grow width 10 px or 10 ppt";
          "Left" = "resize shrink width 10 px or 10 ppt";
          "Down" = "resize grow height 10 px or 10 ppt";
          "Up" = "resize shrink height 10 px or 10 ppt";
          "Right" = "resize grow width 10 px or 10 ppt";
          "Escape" = power-mode;
          "Return" = power-mode;
        };
      };

      keybindings = lib.mkOptionDefault {
        "${mod}+Return" = "exec kitty";
        "${mod}+a" = "exec rofi -show drun";
        "${mod}+e" = "exec pcmanfm";
        "${mod}+w" = "exec firefox";
        "${mod}+x" = "exec kitty nvim";
        "${mod}+q" = "kill";
        "${mod}+f" = "fullscreen toggle";
        "${mod}+r" = ''mode "resize"'';
        "${mod}+m" = "exec warpd-toggle";

        "${mod}+Shift+r" = "restart";
        "${mod}+Shift+w" = "exec rofi-wallpaper";
        "${mod}+Shift+t" = "exec kitty btop";
        "${mod}+Shift+c" = "exec kitty cava";
        "${mod}+Shift+space" = "floating toggle";
        "${mod}+Shift+s" = "exec flameshot gui";
        "${mod}+Shift+v" =
          ''exec rofi -modi "clipboard:greenclip print" -show clipboard -run-command '{cmd}' '';
        "${mod}+Shift+d" = ''exec dunstify -u low -r 12345 "Calendar" "<tt>$(cal)</tt>"'';

        "${mod}+Control+l" = "exec lock-screen";
        "${mod}+Escape" = ''exec ~/.config/eww/scripts/toggle_widget.sh power, mode "power_menu"'';

        "${mod}+s" = "layout stacking";
        "${mod}+g" = "layout tabbed";
        "${mod}+d" = "layout toggle split";
        "${mod}+b" = "split h";
        "${mod}+v" = "split v";

        "${mod}+minus" = "scratchpad show";
        "${mod}+Shift+minus" = "move scratchpad";

        "${mod}+h" = "focus left";
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+l" = "focus right";

        "${mod}+Shift+h" = "move left";
        "${mod}+Shift+j" = "move down";
        "${mod}+Shift+k" = "move up";
        "${mod}+Shift+l" = "move right";

        "${mod}+Shift+p" = "exec playerctl play-pause";
        "${mod}+Shift+n" = "exec playerctl next";
        "${mod}+Shift+b" = "exec playerctl previous";
        "${mod}+Shift+m" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        "${mod}+Shift+Up" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
        "${mod}+Shift+Down" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";

        "XF86AudioPlay" = "exec playerctl play-pause";
        "XF86AudioNext" = "exec playerctl next";
        "XF86AudioPrev" = "exec playerctl previous";
        "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        "XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
        "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        "XF86MonBrightnessUp" = "exec brightnessctl set 5%+";
        "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
      };
    };
  };
}
