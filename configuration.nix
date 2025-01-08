# Edit this configuration file to define what should be installed on your system. Help is available in the
# configuration.nix(5) man page, on https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{ imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true; boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable network manager applet
  programs.nm-applet.enable = true;

  # Set your time zone.
  time.timeZone = "Africa/Algiers";

  # Select internationalisation properties.
  i18n.defaultLocale = "fr_FR.UTF-8";

  i18n.extraLocaleSettings = { LC_ADDRESS = "fr_FR.UTF-8"; LC_IDENTIFICATION = "fr_FR.UTF-8"; LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8"; LC_NAME = "fr_FR.UTF-8"; LC_NUMERIC = "fr_FR.UTF-8"; LC_PAPER = "fr_FR.UTF-8"; LC_TELEPHONE =
    "fr_FR.UTF-8"; LC_TIME = "fr_FR.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = true;

  # Enable dwm
  services.xserver.windowManager.dwm.package = pkgs.dwm.overrideAttrs {
    src = /home/redha/wrk/repo/dwm;
  };
  services.xserver.windowManager.dwm.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = { layout = "fr"; variant = "bepo_latin9";
  };

  # Configure console keymap
  console.keyMap = "fr-bepo";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;

  # Support pulseaudio in all applications
  nixpkgs.config.pulseaudio = true;
  hardware.pulseaudio.extraConfig = "load-module module-combine-sink";

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  users.users.redha = {
    isNormalUser = true;
    description = "redha";
    extraGroups = [ "networkmanager" "wheel" "audio" ];
    packages = with pkgs; [
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
  curl
  dmenu
  dunst
  git
  htop
  mesa
  mesa.drivers
  nnn
  openssl
  picom
  rofi
  sxiv
  tmux
  unzip
  vim
  w3m
  wget
  xclip
  ];

  system.stateVersion = "24.05"; # Did you read the comment?

}
