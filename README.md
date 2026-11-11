# my-nixos

NixOS flake with Home Manager, i3 (X11) and niri (Wayland).

## Usage

```bash
just switch
just update
just fmt
just check
just lint
just clean
```

## Layout

```text
flake.nix
lib/palette.nix
hosts/nixos/
modules/
├── nixos/
│   ├── core.nix
│   ├── desktop.nix
│   ├── fonts.nix
│   ├── hardware.nix
│   ├── programs.nix
│   ├── services.nix
│   ├── virtualisation.nix
│   └── packages/
│       ├── ai.nix
│       ├── audio.nix
│       ├── base.nix
│       ├── cli.nix
│       ├── desktop-tools.nix
│       ├── development.nix
│       ├── fun.nix
│       ├── gui.nix
│       ├── languages.nix
│       └── multimedia.nix
└── home/
    ├── apps/
    ├── editor/nvim/
    ├── services/
    ├── shell/
    ├── theme/
    └── wm/
        ├── eww/
        ├── i3/
        ├── niri.nix
        └── picom.nix
```

## Conventions

- `username`, `hostname`, and `palette` are defined once in `flake.nix` / `lib/palette.nix` and passed to every module.
- Colors come from `lib/palette.nix` (Catppuccin Mocha).
- Tools with a Home Manager module (`bat`, `eza`, `fzf`, `zoxide`, `atuin`, `direnv`, `btop`, `lazygit`, `yazi`, `zathura`) are configured in `modules/home/shell/tools.nix` instead of being installed system-wide.
- `modules/home/editor/nvim` is symlinked out of the store to `~/.config/nvim`.
