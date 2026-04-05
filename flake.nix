{
  description = "Gyunix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    homebrew-brew = {
      url = "github:homebrew/brew";
      flake = false;
    };

    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
      inputs.brew-src.follows = "homebrew-brew";
    };

    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };

    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };

    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, darwin, home-manager, nix-homebrew, homebrew-core, homebrew-cask, homebrew-bundle, ... }@inputs: {
    darwinConfigurations.Gyuruss-MacBook-Air = darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      
      modules = [
        { nixpkgs.config.allowUnfree = true; }

        ./darwin.nix

        home-manager.darwinModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.users.bence = import ./home-darwin.nix;
        }

        nix-homebrew.darwinModules.nix-homebrew {
          nix-homebrew = {
            enable = true;
            enableRosetta = true;
            user = "bence";
            taps = {
              "homebrew/core" = homebrew-core;
              "homebrew/cask" = homebrew-cask;
              "homebrew/bundle" = homebrew-bundle;
            };
            mutableTaps = false;
          };
        }
      ];
    };
  };
}
