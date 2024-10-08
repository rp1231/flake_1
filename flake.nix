{
  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";
    
    jeezyvim.url = "github:LGUG2Z/JeezyVim";
  };

  outputs = { self, nixpkgs, nixos-cosmic, ...}@inputs: {
    nixosConfigurations = {
      #nixpkgs.overlays = [ jeezyvim.overlays.default ];
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          {
            nix.settings = {
              substituters = [ "https://cosmic.cachix.org/" ];
              trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
            };
          }
          nixos-cosmic.nixosModules.default
          ./configuration.nix
        ];
      };
    };
  };
}
