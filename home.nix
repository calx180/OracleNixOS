{ config, pkgs, inputs, ... }:

{
  home.username = "calx";
  home.homeDirectory = "/home/calx";
  home.stateVersion = "26.05";

  programs.fish = {
    enable = true;
    shellAliases = {
      buh = "echo i use NixOS btw";
      mommy = "echo hello good boy";
    };
  };

  programs.starship = {
    enable = true;

    settings = {
      format = " $directory$character";

    directory = {
       style = "bold #b66aff";
    };

    character = {
        success_symbol = "[>](bold #c52cff)";
        error_symbol = "[>](bold #ff3bb5)";
      };
    };
  };

  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];

  programs.spicetify =
    let
      spicePkgs =
        inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      enable = true;

      customColorScheme = {
        text               = "f0e8f5"; # Platinum white
        subtext            = "c8becf"; # Pale silver
        sidebar-text       = "f0e8f5";
        main               = "120e17"; # Midnight dark obsidian background
        sidebar            = "120e17";
        player             = "1c1724"; # Dark slate player bar
        card               = "1c1724";
        shadow             = "0a080d";
        selected-row       = "4a1824"; # Blood-wine row hover / selection
        button             = "ff1744"; # Vivid Crimson play buttons
        button-active      = "ff4d5a"; # Scarlet active state
        button-disabled    = "534a5d";
        tab-active         = "ff1744";
        notification       = "ff1744";
        notification-error = "ff1744";
        misc               = "ff1744";
      };

      enabledExtensions = with spicePkgs.extensions; [
        adblockify
        hidePodcasts
        shuffle
      ];
    };
}
