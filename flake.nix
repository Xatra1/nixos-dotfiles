{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    laminix = {
      url = "github:jackboykin/laminix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      plasma-manager,
      nix-index-database,
      laminix,
      ...
    }@inputs:
    let
      hostname = "lemon";
    in
    {
      overlays.ventoy = final: prev: {
        ventoy = prev.ventoy.overrideAttrs (
          final: prev: {
            version = "1.1.18";

            src = builtins.fetchurl {
              url = "https://github.com/ventoy/Ventoy/releases/download/v${final.version}/ventoy-${final.version}-linux.tar.gz";
              sha256 = "sha256-2G/53mPZTIuPH2sU0jxVr0uI6CB78ok4kIkqapexrVQ=";
            };
          }
        );
      };

      nixosConfigurations."${hostname}" = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./modules/configuration.nix
          laminix.nixosModules.default
          home-manager.nixosModules.home-manager

          {
            nixpkgs.overlays = [ self.overlays.ventoy ];
          }

          {
            home-manager.useGlobalPkgs = true;
            home-manager.users.solarfire = import modules/home-manager;

            home-manager.sharedModules = [
              plasma-manager.homeModules.plasma-manager
              nix-index-database.homeModules.default
            ];
          }
        ];
      };
    };
}
