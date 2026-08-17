{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.silentSDDM.nixosModules.default
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "Oracle"; # Define your hostname.

  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Manila";

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;

    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    extraConfig.pipewire."98-stability" = {
        "context.properties" = {
        "default.clock.rate" = 48000;

        # Larger buffer = more resistant to system load
        "default.clock.quantum" = 1024;
        "default.clock.min-quantum" = 512;
        "default.clock.max-quantum" = 2048;
      };
    };
  };

  programs.silentSDDM = {
    enable = true;
    theme = "catppuccin-mocha";
  };

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };
    
  programs.nix-ld.enable = true;
  programs.fish.enable = true;
  users.users.calx.shell = pkgs.fish;

  services.libinput.enable = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  boot.loader.systemd-boot.configurationLimit = 2;

  users.users.calx = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };
  
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    waybar
    kitty
    foot
    brave
    thunar
    fish
    unzip
    btop
    concord
    rofi
    wget
    mpv
    yazi
    libreoffice
    fastfetch
    vscode
    lavat
    git
    nwg-look
    kdePackages.qtmultimedia
    kdePackages.qtsvg
    kdePackages.qtvirtualkeyboard
    kdePackages.qtimageformats
    cava
    awww
    hyprlandPlugins.borders-plus-plus
    zoom-us
    xfconf
    tumbler
    imv
    helix
    starship
    hyprshot
  ];
  
  fonts.packages = with pkgs; [
    nerd-fonts.go-mono
    nerd-fonts.jetbrains-mono
  ]; 
 
  fonts.fontconfig = {
    enable = true;
    antialias = true;
    subpixel.rgba = "rgb";
    hinting = {
      enable = true;
      style = "slight";
    };
  };

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 100;
    priority = 100;
  };

  # Force kernel to use fast zRAM early instead of waiting for 99% RAM usage
  boot.kernel.sysctl = {
    "vm.swappiness" = 180;
    "vm.watermark_boost_factor" = 0;
    "vm.watermark_scale_factor" = 125;
    "vm.page-cluster" = 0;
  };

  environment.sessionVariables = {
    XCURSOR_THEME = "ArcDusk-cursors";
    XCURSOR_SIZE = "24";
    HYPRCURSOR_THEME = "ArcDusk-cursors";
    HYPRCURSOR_SIZE = "24";
  };
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "26.05"; # Did you read the comment?

}

