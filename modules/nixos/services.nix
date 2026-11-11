{ ... }:

{
  services = {
    flatpak.enable = true;
    ollama.enable = true;
    greenclip.enable = true;
    input-remapper.enable = true;
    blueman.enable = true;
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}
