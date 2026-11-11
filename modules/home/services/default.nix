{ ... }:

{
  imports = [ ./dunst.nix ];

  services = {
    caffeine.enable = true;
    udiskie.enable = true;
  };
}
