{ pkgs, ... }:

let
  scripts = [
    "music_info.sh"
    "toggle_widget.sh"
  ];
  files = [
    "eww.yuck"
    "eww.scss"
    "power.scss"
  ];
in
{
  home.packages = with pkgs; [
    eww
    playerctl
    xdotool
  ];

  xdg.configFile =
    builtins.listToAttrs (
      map (name: {
        name = "eww/${name}";
        value.source = ./config/${name};
      }) files
    )
    // builtins.listToAttrs (
      map (name: {
        name = "eww/scripts/${name}";
        value = {
          source = ./config/scripts/${name};
          executable = true;
        };
      }) scripts
    );
}
