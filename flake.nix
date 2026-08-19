{
	description = "Hyprland on NixOS"; 

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		silentSDDM = {
			url = "github:uiriansan/SilentSDDM";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		  ytm-player = {
    url = "github:peternaame-boop/ytm-player";
    };
	};

	outputs = { self, nixpkgs, home-manager, ... }@inputs: {
		nixosConfigurations.Oracle = nixpkgs.lib.nixosSystem {
			specialArgs = { inherit inputs; };
			modules = [
				./configuration.nix
				home-manager.nixosModules.home-manager
				{
					home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;
						users.calx = import ./home.nix;
						backupFileExtension = "backup";
					};
				}
			];
		};     
	};
}
