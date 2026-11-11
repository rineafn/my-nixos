{ ... }:

{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set -g fish_greeting
      fastfetch
    '';

    shellAliases = {
      cat = "bat --paging=never";
      claude-code = "claude";
    };

    shellAbbrs = {
      ".." = "cd ..";
      "..." = "cd ../..";
      g = "git";
      ga = "git add";
      gc = "git commit";
      gd = "git diff";
      gl = "git log --oneline --graph";
      gp = "git push";
      gs = "git status";
      lg = "lazygit";
      v = "nvim";
      nrs = "nh os switch";
      nrb = "nh os boot";
      nrt = "nh os test";
      nfu = "nix flake update";
    };
  };
}
