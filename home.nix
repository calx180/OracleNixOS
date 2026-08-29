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

      theme = spicePkgs.themes.text;
      colorScheme = "CatppuccinMocha";

      enabledExtensions = with spicePkgs.extensions; [
        adblockify
        hidePodcasts
        shuffle
      ];
    };
}
