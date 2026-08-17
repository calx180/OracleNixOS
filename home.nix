{ config, pkgs, ... }:

{
  home.username = "calx";
  home.homeDirectory = "/home/calx";
  home.stateVersion = "26.05";
  programs.fish = {
    enable = true;
    shellAliases = {
      btw = "echo i use NixOS btw";
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
      success_symbol = "[❯](bold #c52cff)";
      error_symbol = "[❯](bold #ff3bb5)";
   };
  };
 };
}
