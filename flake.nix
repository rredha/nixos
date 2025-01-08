{


	description = "Configuration and home-manager flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
		unstable.url = "github:nixos/nixpkgs/nixos-unstable";
	};

	outputs = { nixpkgs, unstable, ...}: {
		nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			modules = [ ./configuration.nix ];
		};
    extraArgs = {inherit unstable;};


	};

}
