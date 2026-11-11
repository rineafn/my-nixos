{
  inputs,
  palette,
  pkgs,
  ...
}:

{
  imports = [ inputs.noctalia.homeModules.default ];

  programs.noctalia.enable = true;

  home.packages = [ pkgs.wdisplays ];

  xdg.configFile."niri/config.kdl" = {
    force = true;
    text = ''
      spawn-at-startup "noctalia"

      prefer-no-csd

      hotkey-overlay {
          skip-at-startup
      }

      screenshot-path "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"

      cursor {
          xcursor-theme "catppuccin-mocha-dark-cursors"
          xcursor-size 24
      }

      input {
          warp-mouse-to-focus

          touchpad {
              tap
              natural-scroll
              dwt
          }
      }

      layout {
          gaps 16
          center-focused-column "never"

          preset-column-widths {
              proportion 0.33333
              proportion 0.5
              proportion 0.66667
          }

          focus-ring {
              off
          }

          border {
              width 2
              active-color "${palette.mauve}"
              inactive-color "${palette.surface0}"
          }
      }

      window-rule {
          geometry-corner-radius 12
          clip-to-geometry true
      }

      binds {
          Mod+Shift+Slash { show-hotkey-overlay; }

          Mod+Return { spawn "kitty"; }
          Mod+D { spawn "sh" "-c" "noctalia msg panel-toggle launcher"; }
          Mod+S { spawn "sh" "-c" "noctalia msg panel-toggle control-center"; }
          Mod+L { spawn "sh" "-c" "noctalia msg session lock"; }
          Mod+E { spawn "pcmanfm"; }
          Mod+W { spawn "firefox"; }
          Mod+M { spawn "warpd-toggle"; }

          Mod+Q { close-window; }
          Mod+Shift+Q { quit; }
          Mod+O { toggle-overview; }

          Mod+F { maximize-column; }
          Mod+Shift+F { fullscreen-window; }
          Mod+Shift+Space { toggle-window-floating; }
          Mod+R { switch-preset-column-width; }
          Mod+Minus { set-column-width "-10%"; }
          Mod+Equal { set-column-width "+10%"; }

          Mod+Shift+S { screenshot; }
          Print { screenshot; }
          Ctrl+Print { screenshot-screen; }
          Alt+Print { screenshot-window; }

          Mod+Left  { focus-column-left; }
          Mod+Down  { focus-window-down; }
          Mod+Up    { focus-window-up; }
          Mod+Right { focus-column-right; }

          Mod+Shift+Left  { move-column-left; }
          Mod+Shift+Down  { move-window-down; }
          Mod+Shift+Up    { move-window-up; }
          Mod+Shift+Right { move-column-right; }

          Mod+Tab { focus-workspace-previous; }
          Mod+Page_Down { focus-workspace-down; }
          Mod+Page_Up { focus-workspace-up; }

          Mod+1 { focus-workspace 1; }
          Mod+2 { focus-workspace 2; }
          Mod+3 { focus-workspace 3; }
          Mod+4 { focus-workspace 4; }
          Mod+5 { focus-workspace 5; }

          Mod+Shift+1 { move-column-to-workspace 1; }
          Mod+Shift+2 { move-column-to-workspace 2; }
          Mod+Shift+3 { move-column-to-workspace 3; }
          Mod+Shift+4 { move-column-to-workspace 4; }
          Mod+Shift+5 { move-column-to-workspace 5; }

          XF86AudioRaiseVolume allow-when-locked=true { spawn "wpctl" "set-volume" "-l" "1.0" "@DEFAULT_AUDIO_SINK@" "5%+"; }
          XF86AudioLowerVolume allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-"; }
          XF86AudioMute allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }
          XF86AudioPlay allow-when-locked=true { spawn "playerctl" "play-pause"; }
          XF86AudioNext allow-when-locked=true { spawn "playerctl" "next"; }
          XF86AudioPrev allow-when-locked=true { spawn "playerctl" "previous"; }
          XF86MonBrightnessUp allow-when-locked=true { spawn "brightnessctl" "set" "5%+"; }
          XF86MonBrightnessDown allow-when-locked=true { spawn "brightnessctl" "set" "5%-"; }
      }
    '';
  };
}
