{
  /* 
    TODO:
      Funnel stable to host system and unstable to local environment
  */
  description = "hallwebway.net";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = { url = "github:nix-community/home-manager";
      inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    };
  };
  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
      mars = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./nixos/configuration.nix 
          ./nixos/hardware-configuration.nix
        ];
      };
    };    
    homeConfigurations = {
      "jhall@mars" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit inputs; };
        modules = [ ./home-manager/home.nix ];
      };
    };
  };
}
