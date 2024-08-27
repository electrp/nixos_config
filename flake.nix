{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    rust-overlay.url = "github:oxalica/rust-overlay";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: let 
    inherit (self) outputs;
  in rec{
    overlays = import ./overlays/unstable.nix {inherit inputs;};

    homeConfigurations = {
      electrp = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {};
	extraSpecialArgs = {inherit inputs outputs;};
      };
    };

    # Please replace my-nixos with your hostname
    nixosConfigurations.electrp = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs outputs; };
      modules = [
        # Import the previous configuration.nix we used,
        # so the old configuration file still takes effect
        ./configuration.nix

	./bluetooth.nix
	./bootloader.nix
	./fonts.nix
	./wayland.nix
	./pipewire.nix
	./devices.nix
	./rust.nix

	home-manager.nixosModules.home-manager 
	{
          home-manager.useGlobalPkgs = true;
	  home-manager.useUserPackages = true;

          home-manager.extraSpecialArgs = {inherit inputs outputs;};

	  # TODO replace ryan with your own username
	  home-manager.users.will = import ./will.nix;

	  # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
        }
      ];
    };

    
  };
}
