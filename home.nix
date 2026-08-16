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
}
