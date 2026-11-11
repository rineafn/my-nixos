{
  description = "My NixOS dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      username = "fukukita";
      hostname = "nixos";
      pkgs = nixpkgs.legacyPackages.${system};
      palette = import ./lib/palette.nix;
    in
    {
      nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit
            inputs
            username
            hostname
            palette
            ;
        };
        modules = [
          ./hosts/${hostname}
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "bak";
              extraSpecialArgs = { inherit inputs username palette; };
              users.${username} = import ./modules/home;
            };
          }
        ];
      };

      formatter.${system} = pkgs.nixfmt-tree;

      checks.${system}.formatting =
        pkgs.runCommand "check-formatting" { nativeBuildInputs = [ pkgs.nixfmt ]; }
          ''
            find ${self} -name '*.nix' -exec nixfmt --check {} +
            touch $out
          '';

      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          deadnix
          just
          nh
          nil
          nixfmt
          statix
        ];
      };
    };
}
