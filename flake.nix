{
  description = "Home Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
  };
  
  outputs = inputs @ { self, flake-parts, home-manager, nixpkgs, ... }: 
  flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        # To import a flake module
        # 1. Add foo to inputs
        # 2. Add foo as a parameter to the outputs function
        # 3. Add here: foo.flakeModule

      ];
    flake = {
      homeConfigurations.mwdavisii = home-manager.lib.homeManagerConfiguration {
        modules = [
          ./home/home.nix
      ];
      };
    };
  };
}