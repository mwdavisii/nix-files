{
  description = "Home Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    flake-parts.url = "github:hercules-ci/flake-parts";
    agenix.url = "github:ryantm/agenix";
  };

  outputs = inputs@{ self, home-manager, nixpkgs, ... }: {
    defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;
    
    homeConfigurations = {
      "mwdavisii" = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        system = "x86_64-linux";
        homeDirectory = "/home/mwdavisii"; 
        username = "mwdavisii"; 
        configuration.imports = [ ./home.nix ];
      };
    };
  };
}