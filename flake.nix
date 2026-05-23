{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
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
    {
      nixosConfigurations = {
        pc = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ 
            ./configuration.nix
            ./hosts/pc/hardware-configuration.nix 
          ];
        };
        thinkpad = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration.nix
            ./hosts/thinkpad/hardware-configuration.nix

          ];
        };
        nixos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration.nix
            ./hosts/nixos/hardware-configuration.nix
            home-manager.nixosModules.default {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.mikolaj = ./home.nix;            
    	      };
            }
          ];
        };
      };
    };
}
