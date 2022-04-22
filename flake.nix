{
  description = "system configuration of satelite";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs:
    let
      system = "aarch64-linux";
      username = "smaftoul";
    in
    {
      homeConfigurations.${username} = inputs.home-manager.lib.homeManagerConfiguration {
        # Specify the path to your home configuration here
        configuration = import ./home.nix;

        inherit system username;
        homeDirectory = "/home/${username}";
        # Update the state version as needed.
        # See the changelog here:
        # https://nix-community.github.io/home-manager/release-notes.html#sec-release-21.05
        stateVersion = "21.11";

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };

      nixosConfigurations = {

        satelite = inputs.nixpkgs.lib.nixosSystem {
          #system = "x86_64-linux";
          inherit system;
          modules = [
            inputs.home-manager.nixosModules.home-manager
            ./configuration.nix
          ];
          specialArgs = { inherit inputs; };
        };
      };
    };
}
