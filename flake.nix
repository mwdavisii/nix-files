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
  
  outputs = inputs @ { self, home-manager, nixpkgs, ... }: 
    
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    #pkgs.${system}.defaultPackage = nixpkgs.legacyPackages.${system};
    
  in {
    defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;
    homeConfigurations.mwdavisii = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        ./home.nix
      ];
    };
  };
}