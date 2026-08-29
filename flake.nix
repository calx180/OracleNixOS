{
	description = "Hyprland on NixOS"; 

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		spicetify-nix.url = "github:Gerg-L/spicetify-nix";
		
		silentSDDM = {
			url = "github:uiriansan/SilentSDDM";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		  ytm-player = {
    url = "github:peternaame-boop/ytm-player";
    };
	};

	outputs = { self, nixpkgs, home-manager, spicetify-nix, ... }@inputs: {
		nixosConfigurations.Oracle = nixpkgs.lib.nixosSystem {
			specialArgs = { inherit inputs; };
			modules = [
				./configuration.nix
				home-manager.nixosModules.home-manager
				{
					home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;

						extraSpecialArgs = {
              inherit inputs;
            };
						
						users.calx = import ./home.nix;
						backupFileExtension = "backup";
					};
				}
			];
		};     
	};
}
