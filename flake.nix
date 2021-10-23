{
  description = "A NixOS flake for Lee's personal computer.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.05";
    herc.url = "github:hercules-ci/hercules-ci-agent";
  };

  outputs = { self, nixpkgs, herc, ... }@inputs: {
    nixosConfigurations = {
     z620  = nixpkgs.lib.nixosSystem {   #this is the hostname = some func
        system = "x86_64-linux";
        modules = [
          (import ./hosts/z620/configuration.nix)
          herc.nixosModules.agent-service
        ];
        specialArgs = { inherit inputs; };
      };
    };
  };
}
